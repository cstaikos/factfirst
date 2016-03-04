class CommentsController < ApplicationController

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
end
