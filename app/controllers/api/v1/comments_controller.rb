class Api::V1::CommentsController < ApplicationController

  before_action :set_comment, only: [:update,:destroy]
  before_action :set_ticket
  # before_action :authenticate_user!

  def index
    comments = {
        ticket_id: params[:ticket_id],
        comments: ActiveModel::SerializableResource.new(@ticket.comments)
    }
    render :json => comments
  end

  def create

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
