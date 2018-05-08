class ApiController < ActionController::API

  before_action :authenticate_user!

  protected

  def authenticate_user!
    unless current_user && !current_user.anonymous?
      render json: { message: 'Access Denied', status: 'unauthorized' }, status: :unauthorized
    end
  end

  def current_user
    token = request.headers['Authorization']
    return nil unless token.present?
    decoded = Access::Token.decode(authorization: token)
    if decoded && decoded['id']
      User.where(id: decoded['id']).first
    end
  end


  def api_response(data:,
                   success: response.status < 300,
                   message: status_message(success: success, record: data),
                   serializer: serializer_for_record(data))
    {
      json: {
        success: success,
        data: serialized_data(data, serializer),
        message: message,
      }
    }
  end

  def serialized_data(data, serializer)
    return data unless serializer
    if data.is_a?(ActiveRecord::Relation)
      data.map{|record| serializer.new(record).as_json }
    else
      serializer.new(data).as_json
    end
  end

  def serializer_for_record(data)
    klass = data.is_a?(ActiveRecord::Relation) ? data.klass : data.class
    "#{klass.to_s}Serializer".constantize
  end

  ACTION_STATUS_NAMES = {
    'index' => 'retrieval',
  }

  def status_message(success:, record:)
    type =  ACTION_STATUS_NAMES[action_name] || action_name
    if success
      type + " succeeded"
    elsif record
      msg = type + " failed"
      if record.is_a?(ActiveRecord::Base)
        msg += ": " + record.errors.full_messages.join("; ")
      end
    else
      return "Record not found"
    end

  end

end
