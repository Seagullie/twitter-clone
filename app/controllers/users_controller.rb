class UsersController < ApplicationController
    before_action :user
    

    def profile
        @is_following = is_following

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

    def follow
        # byebug
        association = Follow.new
        association.user_id = current_user.id
        association.is_following = @user.id

        association.save

        profile
        
    end
    
    def unfollow
        association = Follow.where(user_id: current_user.id, is_following: @user.id)
        # byebug
        association.destroy(association.ids[0])
   
        profile
    end

    def is_following
        association_present = Follow.where(user_id: current_user.id, is_following: @user.id).length != 0

        return association_present
    end

    private

    def user
        target_handle = params[:handle]
        @user =  User.find_by(username: target_handle)
    end
end
