class CommentsController < ApplicationController
  before_action :login_to_add_comment, only: [:create]

  def create
    @fact = Fact.find(params[:fact_id])
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.fact = @fact

    if @comment.save
      redirect_to @fact
    else
      redirect_to @fact, notice: "Error saving comment"
    end
  end


  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def login_to_add_comment
    unless current_user
      redirect_to new_user_session_path, alert: "Please login to add a Comment!"
    end
  end
end
