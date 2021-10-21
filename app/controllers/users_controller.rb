class UsersController < ApplicationController
    def show
        @user = User.find(params[:id])
        if current_user.id != @user.id
            render :file => "#{Rails.root}/public/404.html",  layout: false, status: :not_found
        end
    end
end
