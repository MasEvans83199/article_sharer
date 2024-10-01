class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_admin
  
    def index
      @users = User.all
    end
  
    def assign_role
      user = User.find(params[:id])
      if params[:role] == 'moderator'
        user.add_role :moderator unless user.has_role?(:moderator)
      elsif params[:role] == 'remove_moderator'
        user.remove_role :moderator if user.has_role?(:moderator)
      end
      redirect_to users_path, notice: 'Role updated successfully'
    end
  
    private
  
    def ensure_admin
      unless current_user.has_role?(:admin)
        redirect_to root_path, alert: "Unauthorized access!"
      end
    end
  end
  