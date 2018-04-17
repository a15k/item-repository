class Api::V1::InteractionsController < ApiController

  def index
    apps = interactions_api.get_apps(group_id: current_user.member.id)
    render json: apps
  end


  def create
    app = interactions_api.create_app(group_id: current_user.member.id)
    render json: app
  end

  def destroy
    interactions_api.delete_app(params[:id])
    head :no_content
  end

  private

  def interactions_api
    Rails.env.test? ? Interactions::FakeApi : A15kInteractions::AppsApi.new
  end

end
