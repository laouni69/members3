class UsersController < ApplicationController
    before_action :logged_in_user, only: [:index, :edit, :update]
    before_action :correct_user,   only: [:edit, :update]
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            log_in @user
            flash[:success] = "Bienvenue chez The Hacking Project"
            redirect_to @user
        else
            render 'new'
        end
    end
    
    def index
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update_attributes(user_params)
            flash[:success] = "Profil modifié"
            redirect_to @user
        else

            render 'edit'
        end
    end
    
    private
    def user_params
        params.require(:user).permit(:email, :password)
    end
    
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Veuillez vous connecter"
        redirect_to login_url
      end
    end
    
    def correct_user
        @user = User.find(params[:id])
        redirect_to(root_url) unless current_user?(@user)
    end
end
