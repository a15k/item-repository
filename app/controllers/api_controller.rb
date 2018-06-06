class ApiController < ActionController::API

  before_action :authenticate_member!
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  protected

  def authenticate_member!
    return true if current_member
    if authorization_token.present?
      render api_response(
               data: {}, success: false, message: 'Access is Forbidden', serializer: false
             ).merge(status: :forbidden)
    else
      render api_response(
               data: {}, success: false, message: 'Access Denied', serializer: false
             ).merge(status: :unauthorized)
    end
  end

  def render_invalid_response(message: 'invalid!', status: :not_acceptable)
    render api_response(
               serializer: false,
               message: message,
               data: {},
               success: false
             ).merge(status: status)
  end

  def authorization_token
    request.headers['Authorization']
  end

  def current_member
    @current_member ||= (
      authorization_token.present? ? AccessToken.member_for(jwt: authorization_token) : nil
    )
  end

  def api_response(data:,
                   success: response.status < 300,
                   message: status_message(success: success, record: data),
                   serializer: serializer_for_record(data))
    {
      json: {
        success: success,
        data: serialized_data(data, serializer),
        message: message
      }
    }
  end

  def record_not_found
    render api_response(
             data: {}, success: false, message: 'Not Found', serializer: false
           ).merge(status: :not_found)
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
    "#{self.class.to_s.deconstantize}::#{klass.to_s}Serializer".constantize
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
