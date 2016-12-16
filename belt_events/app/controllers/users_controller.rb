class UsersController < ApplicationController
  def new
    @states = State.all
  end

  def create
    form = params[:user]
    if form[:password] == form[:password_confirmation]
      state = State.find(form[:state_id])
      user = User.new(user_params)
      user.state = state
      user.save
      flash[:msg] = "Successfully registered!"
    else
      flash[:msg] = "Invalid credentials!"
    end
    redirect_to '/'
  end

  def edit
    user = params[:id]
    @user = User.find(user)
    @states = State.all
  end

  def update
    form = params[:user]
    @user = User.find(params[:id])
    @user.attributes = user_params
    state = State.find(form[:state_id])
    @user.state = state
    if @user.save
      flash[:msg] = "User successfully updated"
      redirect_to "/events"
    else
      flash[:msg] = @user.errors.full_messages
      redirect_to :back
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :location, :password_confirmation, :state_id)
  end
end
