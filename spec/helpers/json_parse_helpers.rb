module JsonParseHelpers

  def request_json
    JSON.parse(response.body)
  end

end
