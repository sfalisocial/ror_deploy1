class SessionsController < ApplicationController
  def new
    form = params[:user]
    user = User.find_by_email(form[:email])
    if user && user.authenticate(form[:password])
      flash[:msg] = "Successfully logged in!"
      session[:user_id] = user.id
      redirect_to "/events"
    else
      flash[:msg] = "Invalid credintials"
      redirect_to "/"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end
end
