class Api::V1::InteractionsController < ApiController

  def index
    apps = A15K::Interactions.api.get_apps(group_id: current_member.id)
    render api_response data: apps, serializer: false
  end


  def create
    app = A15K::Interactions.api.create_app(group_id: current_member.id)
    render api_response data: app, serializer: false
  end

  def destroy
    A15K::Interactions.api.delete_app(params[:id])
    head :no_content
  end

  def update
    app = params.require(:interaction).permit(:name, whitelisted_domains: [])
    A15K::Interactions.api.update_app(params[:id], app: app)
    render api_response data: app, serializer: false
  end

end
