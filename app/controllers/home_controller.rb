class HomeController < ApplicationController

  layout 'home'

  def index
    render case
           when current_user.can_access_ui? then 'application'
           when current_user.anonymous? then 'login'
           else
             'access_denied'
           end
  end
end
