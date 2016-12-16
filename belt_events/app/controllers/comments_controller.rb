class CommentsController < ApplicationController
  def create
    event = Event.find(params[:id])
    user = current_user
    Comment.create(user:user, event:event, content: params[:content])
    redirect_to :back
  end
end
