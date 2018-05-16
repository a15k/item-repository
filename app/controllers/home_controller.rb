class HomeController < ApplicationController

  layout 'application', only: [:index]
  layout 'static', except: [:index]

end
