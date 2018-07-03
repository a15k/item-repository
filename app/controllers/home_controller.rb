class HomeController < ApplicationController

  layout 'home'

  def index
    render current_user.anonymous? ? 'login' : 'application'
  end
end
