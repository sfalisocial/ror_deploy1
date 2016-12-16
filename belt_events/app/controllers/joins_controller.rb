class JoinsController < ApplicationController
  def create
    event = Event.find(params[:id])
    user = current_user
    Guest.create(user:user, event:event)
    redirect_to :back
  end
  def destroy
    puts "HELLO IM HERE"
    join = Guest.find_by(event:params[:id])
    Guest.find_by(event:params[:id]).destroy if join.user == current_user
    redirect_to :back
  end
end
