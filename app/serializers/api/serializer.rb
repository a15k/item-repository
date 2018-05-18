module Api

  class Serializer < Roar::Decorator
      include Roar::JSON
      include Swagger::Blocks

      ROAR_OPTION_KEYS = %i[reader extend class collection readable writeable]
      INTERNAL_OPTION_KEYS = %i[document]

      class << self
        alias_method :original_swagger_schema, :swagger_schema

        def swagger_schema(name, &block)
          @schema_name = name
          original_swagger_schema(name, &block)
        end

        def property(key, options = {}, &options_block)
          roar_options = options.extract!(*ROAR_OPTION_KEYS)
          swagger_options = options.except(*INTERNAL_OPTION_KEYS)

          # Roar serialization
          super(key, roar_options, &nil) # define property for Roar. must pass nil for block

          return if options[:document] == false

          # swagger documentation
          original_swagger_schema schema_name do
            if options_block
              property key, swagger_options do
                options_block.call(self)
              end
            else
              property key, swagger_options
            end
          end
        end

        def schema_name
          @schema_name ||= guessed_schema_name
        end

        def guessed_schema_name
          self.to_s.sub(/Serializer$/, '').demodulize
        end

        def collection
          # all collection does is call property with collection: true internally
          raise "Use property with 'collection: true' option instead of collection"
        end
      end
  end
end
