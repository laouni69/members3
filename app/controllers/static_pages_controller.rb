class StaticPagesController < ApplicationController
    before_action :logged_in_user, only: [:reponse]

    def home
    end
    
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Veuillez vous connecter"
        redirect_to login_url
      end
    end
end
