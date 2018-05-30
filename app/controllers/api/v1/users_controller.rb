class Api::V1::UsersController < ApiController

  include Swagger::Blocks

  swagger_path '/users' do
    operation :get do
      key :summary, 'Get all users for the membership'
      key :description, 'List all users'
      key :operationId, 'getUsers'
      security do
        key :api_token, []
      end
      key :tags, ['Users']

      extend Api::SwaggerResponses
      include_404_schema
      include_success_schema(model: 'User', format: :array)
    end
  end
  def index
    render api_response data: current_member.users
  end

  swagger_path '/users/add' do
    operation :post do
      key :summary, 'add a newly created user account to a membership'
      key :operationId, 'claimUser'
      security do
        key :api_token, []
      end
      key :tags, ['Users']
      parameter do
        key :name, :username
        key :in, :path
        key :description, 'username of user to join to membership'
        key :required, true
      end
      parameter do
        key :name, :role
        key :in, :body
        key :description, 'role to grant to user'
        key :required, true
      end
      extend Api::SwaggerResponses
      include_404_schema
      include_success_schema(model: 'User')
      response 406 do
        key :description, 'Given user cannot be added to membership'
      end
    end
  end
  def add
    user = User
      .where(openstax_accounts_accounts: {username: params[:username]})
      .joins(:account)
      .first!
    if user.member
      render api_response(
               serializer: false,
               message: 'unable to claim already claimed account',
               data: {},
               success: false
             ).merge(status: :not_acceptable)
      return
    end
    user.role = params[:role]
    current_member.users << user
    render api_response data: user, success: true
  end

  swagger_path '/users/{id}' do
    operation :put do
      key :summary, 'alter a user'
      key :operationId, 'updateUser'
      security do
        key :api_token, []
      end
      key :tags, ['Users']
      parameter do
        key :name, :role
        key :in, :body
        key :description, 'role to grant to user'
        key :required, true
      end
      extend Api::SwaggerResponses
      include_404_schema
      include_success_schema(model: 'User')
    end
  end
  def update
    user = User.find(params[:id])
    if validate_member(user)
      user.assign_attributes(params.permit(:role))
      render api_response data: user, success: user.save
    end
  end


  swagger_path '/users/{id}' do
    operation :delete do
      key :summary, 'remove a user from membership'
      key :operationId, 'deleteUser'
      security do
        key :api_token, []
      end
      key :tags, ['Users']

      extend Api::SwaggerResponses
      include_404_schema
      include_success_schema(model: 'User')
    end
  end
  def destroy
    user = User.find(params[:id])
    if validate_member(user)
      user.member_id = nil
      render api_response data: user, success: user.save
    end
  end

  private

  def validate_member(user)
    if user.member != current_member
      render api_response(
               serializer: false, message: 'not allowed', data: {}, success: false
             ).merge(status: :forbidden)
      return false
    end
    return true
  end
end
