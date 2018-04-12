# coding: utf-8
class Api::V1::FormatsController < ApiController
  def index
    render json: FormatSerializer.new(Format.all).serialized_json
  end
end
