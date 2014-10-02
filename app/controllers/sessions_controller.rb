class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(user_params)
    if user
      session[:session_token] = user.reset_session_token!
      redirect_to users_url
    else
      flash.now[:errors] = "Wrong username or password"
      render :new
    end
  end

  def destroy
    session[:session_token] = nil
    redirect_to new_session_url
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end

end
