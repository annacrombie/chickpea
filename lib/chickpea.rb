require 'chickpea/version'

module Chickpea
  class TypeError < ::TypeError
    def initialize(got, expected)
      super("expected #{got.inspect} to be a #{expected}")
    end
  end

  class<<self
    def make_stash(hash)
      klass = Class.new

      hash.map do |key, val|
        obj =
          if val.is_a?(Hash)
            make_stash(val)
          else
            val.tap do |v|
              case v
              when true, false
                klass.define_method(:"#{key}?") { obj }
                klass.define_method(:"#{key}=") do |nv|
                  unless nv == true || nv == false
                    raise(TypeError.new(nv, :Boolean))
                  end

                  define_singleton_method(key) { nv }
                end
              else
                klass.define_method(:"#{key}=") do |nv|
                  unless nv.is_a?(obj.class)
                    raise(TypeError.new(nv, obj.class.name))
                  end

                  define_singleton_method(key) { nv }
                end
              end
            end
          end

        klass.define_method(key) { obj }
      end

      klass.define_method(:to_h) do
        hash.map do |k, v|
          [k, send(k).then { |r| v.is_a?(Hash) ? r.to_h : r }]
        end.to_h
      end

      klass.define_method(:merge!) do |hash|
        hash.each do |k, v|
          v.is_a?(Hash) ? send(k).merge!(v) : send(:"#{k}=", v)
        end
      end

      klass.new
    end

    alias new make_stash
  end
end
