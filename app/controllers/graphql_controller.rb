class GraphqlController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def execute


    variables = ensure_hash(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      current_user: current_user
    }
    result = ItemRepositorySchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  end

  private

  def authenticate_user!
    unless current_user
      render json: { message: 'Access Denied', status: 'unauthorized' }, status: :unauthorized
    end
  end

  def current_user
    user = super
    return user if user.present? && !user.anonymous?
    if request.headers['Authorization']
      token = Access::Token.decode(authorization: request.headers['Authorization'])
      if token && token['id']
        User.where(id: token['id']).first
      end
    end
  end

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end
end
