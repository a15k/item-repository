module JsonParseHelpers

  def response_json
    JSON.parse(response.body)
  end

  def response_data
    response_json['data']
  end

end
