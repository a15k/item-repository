class Api::V1::UsersController < ApiController

  include Swagger::Blocks

  swagger_path '/users' do
    operation :get do
      key :summary, 'Get all users for the member'
      key :operationId, 'getUsers'
      security do
        key :api_token, []
      end
      key :tags, ['Users']

      extend Api::SwaggerResponses
      include_success_schema(model: 'User', format: :array)
    end
  end
  def index
    render api_response data: current_member.users
  end

  swagger_path '/users/add' do
    operation :post do
      key :summary, 'add a newly created user account to a member'
      key :operationId, 'claimUser'
      security do
        key :api_token, []
      end
      key :tags, ['Users']
      parameter do
        key :name, :email
        key :in, :path
        key :description, 'email of user to join to member'
        key :required, true
      end
      parameter do
        key :name, :role
        key :in, :body
        key :description, 'role to grant to user'
        key :required, true
      end
      extend Api::SwaggerResponses
      include_success_schema(model: 'User')
      response 406 do
        key :description, 'Given user cannot be added to member'
      end
    end
  end
  def add
    outputs = ::OpenStax::Accounts::FindOrCreateAccount.call(
        email: params[:email],
        username: params[:email],
        password: false,
      ).outputs

    if outputs.errors?
      render api_response(
               errors: outputs.errors.full_messages,
               data: {}, serializer: false, message: "Failed to create user",
               success: false
             )
      return
    end
    user = User
      .where(openstax_accounts_accounts: {id: outputs.account.id})
      .joins(:account)
      .first
    if user && user.member && user.member != current_member
      render api_response(success: false, message: 'unable to invite user')
      return
    end
    user ||= User.new
    user.role = params[:role] || 'standard_user'
    user.member = current_member
    user.account = outputs.account

    render api_response data: user, success: user.save
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
      user.assign_attributes(params.slice(:role).permit(:role))
      render api_response data: user, success: user.save
    end
  end


  swagger_path '/users/{id}' do
    operation :delete do
      key :summary, 'remove a user from member'
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
      current_member.users.delete user
      render api_response data: user, success: current_member.save
    end
  end

  private

  def validate_member(user)
    if user.member != current_member
      render api_response(
               success: false, status: :forbidden,
               serializer: false, message: 'not allowed')
      return false
    end
    return true
  end
end
