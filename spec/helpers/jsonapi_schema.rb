module JsonApiSchema

  def model_schema(model, attrs = {})
    serializer = "#{model.name}Serializer".constantize
    serialized = serializer.attributes_to_serialize
    {
      title: model.name,
      type: 'object',
      required: %w[id type],
      properties: {
        id: { type: :string, format: :uuid },
        type: { type: :string },
        attributes: {
          type: 'object',
          properties: serialized.transform_values { |v|
            { type: :string }
          }
        }.merge(attrs)
      }
    }
  end


  def json_api_list_schema(model, schema = {})
    {
      type: :object,
      required: ['data'],
      properties: {
        data: {
          type: 'array',
          items: model_schema(model)
        }
      }
    }.deep_merge(schema)
  end

  def json_api_show_schema(model, schema = {})
    {
      type: :object,
      required: ['data'],
      properties: {
        data: model_schema(model)
      }
    }.deep_merge(schema)
  end

  def json_api_create_schema(model, schema = {})
    {
      type: :object,
      required: ['data'],
      properties: {
        data: model_schema(model)
      }
    }.deep_merge(schema)
  end

end
