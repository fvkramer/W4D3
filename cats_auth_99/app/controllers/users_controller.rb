class UsersController < ApplicationController
  def new
    @user = User.all.first 
    render :new
  end
  
  def create
    user = User.create(user_params)
    login(user)
    if user.save!
      redirect_to user_url(user)
    end
  end
  
  def show
    @user = User.find(params[:id])
    render :show
  end
  
  private
  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end
