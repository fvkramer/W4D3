class SessionsController < ApplicationController
    def new
      render '/users/new' 
    end
    
    def create
      user = User.find_by_credentials(params[user][username], params[user][password])
      if user
        user.reset_session_token!
        redirect_to cats_url
      else
        flash.now[:session] = ["User not found"]
        render '/cats/index'
      end
    end
end