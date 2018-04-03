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

end
