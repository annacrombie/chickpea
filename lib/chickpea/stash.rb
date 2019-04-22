module Chickpea
  class Stash
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
                      raise(TypeError, "expected #{nv.inspect} to be a Boolean")
                    end

                    define_singleton_method(key) { nv }
                  end
                else
                  klass.define_method(:"#{key}=") do |nv|
                    unless nv.is_a?(obj.class)
                      raise(TypeError, "expected #{nv.inspect} to be a #{v.class}")
                    end

                    define_singleton_method(key) { nv }
                  end
                end
              end
            end

          klass.define_method(key) { obj }
        end

        klass.new
      end

      alias new make_stash
    end
  end
end
