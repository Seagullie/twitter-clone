class UsersController < ApplicationController
    before_action :user
    before_action :get_is_following, except: [:search]
    # before_action :is_following
    

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

    def get_is_following
        # console
        if not current_user
            @is_following = false
            return true
        end

        @is_following = Follow.where(user_id: current_user.id, is_following: @user.id).length != 0
        # byebug
        return true
    end

    def follow_list
        @follow_list = @user.follows.map {|follow| User.find(follow.is_following)}
        # byebug
        render '/users/follow_list', user: @user
    end

    def followers
        @followers = Follow.where(is_following: @user.id).map {|follow| User.find(follow.user_id)}
        # byebug
        render '/users/followers', user: @user
    end


    def search
        search_query = params[:search_data]
        results = search_for_user(search_query)
        p results
        # byebug
        if results.length == 0
            render js: "  M.toast({html: 'Failed to find the user', classes: 'red'})"
            return false
        end
        formatted_results = results[0].name + " " + results[0].username
        p formatted_results
        js_to_render = %Q(alert("Test Successfull, you are trying to search for #{formatted_results}"))
        p js_to_render
        render js: "window.location.href = '/#{results[0].username}';"
        

        # redirect_to "/#{results[0].username}"

    end

    private

    def user
        target_handle = params[:handle]
        @user =  User.find_by(username: target_handle)
    end

    def search_for_user(data)
        users = User.where(name: data) + User.where(username: data)

        return users
    end
    
end
