module Api::SwaggerResponses


  def self.extended(base)
    base.response 401 do
      key :description, 'Not authorized'
    end

    base.response 403 do
      key :description, 'Forbidden'
    end

    base.response 404 do
      key :description, 'Not found'
    end

    base.response 500 do
      key :description, 'Server error.'
      schema do
        key :'$ref', :Error
      end
    end

  end

  def success_schema(
        model:,
        format: :single,
        description: "Success.  Returns all #{model.downcase.pluralize}"
      )

    response 200 do
      key :description, description
      schema do
        property :success do
          key :type, :boolean
          key :description, 'Flag indicating if request was successfull'
        end
        property :message do
          key :type, :string
          key :description, 'A message describing the request status'
        end
        property :data do
          if format == :array
            key :type, :array
            items do
              key :'$ref', model
            end
          else
            key :'$ref', model
          end
        end
      end
    end
  end
end
