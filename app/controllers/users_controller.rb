class UsersController < ApplicationController

    def profile
        user_handle = params[:handle] 
        @user = user =  User.find_by(username: user_handle)
        if current_user == user
            redirect_to root_path
        else
            @tweeets = user.tweeets
            p user_handle, user, @tweeets
            render '/users/profile'#, locals: {tweeets: @tweeets}
        end
    end
end
