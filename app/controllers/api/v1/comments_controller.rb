class Api::V1::CommentsController < ApplicationController

  before_action :set_comment, only: [:update,:destroy]
  before_action :set_ticket
  # before_action :authenticate_user!

  def index
    render :json => @ticket.comments
  end

  def create
    params = comment_params.merge(user_id: current_user.id)
    @comment = Comment.create(params)
    render :json => @comment
  end

  def update

  end

  def destroy

  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end

  def set_comment
    @comment = Comment.find(comment_params[:id])
  end

  def comment_params
    params.require(:comment).permit(:id,:ticket_id,:user_id,:comment)
  end
end
