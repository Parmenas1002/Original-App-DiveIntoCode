class UsersController < ApplicationController
    def show
        @user = User.find(params[:id])
        if current_user.id != @user.id
            render :file => "#{Rails.root}/public/404.html",  layout: false, status: :not_found
        end
    end
    def new_guest
        user = User.find_by(email:"guest@example.com")
        if user
            sign_in user
        end
        redirect_to root_path
    end
    def new_admin_guest
        user = User.find_by(email: "guestadmin@example.com")
        if user
            sign_in user
        end
        redirect_to root_path
    end
end
