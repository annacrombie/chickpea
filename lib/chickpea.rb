require 'chickpea/version'

module Chickpea
  class TypeError < ::TypeError
    def initialize(got, expected)
      super("expected #{got.inspect} to be a #{expected}")
    end
  end

  class<<self
    def def_accessors(klass, key, nv)
      (
        case nv
        when true, false
          [[:"#{key}?", -> { nv }]]
        else
          []
        end + [[:"#{key}", -> { nv }]]
      ).each do |(meth, block)|
        klass.define_method(meth, &block)
      end
    end

    def check_type(obj, nv)
      case obj
      when true, false
        unless nv == true || nv == false
          raise(TypeError.new(nv, :Boolean))
        end
      else
        unless nv.is_a?(obj.class)
          raise(TypeError.new(nv, obj.class.name))
        end
      end
    end

    def make_stash(hash)
      klass = Class.new

      hash.each do |key, val|
        obj =
          if val.is_a?(Hash)
            make_stash(val)
          else
            klass.define_method(:"#{key}=") do |nv|
              Chickpea.check_type(val, nv)

              Chickpea.def_accessors(klass, key, nv)
            end

            val
          end

        Chickpea.def_accessors(klass, key, obj)
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
