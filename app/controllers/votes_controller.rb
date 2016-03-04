class VotesController < ApplicationController
  before_action :login_to_vote
  before_action :load_evidence

  def create

    if current_user.already_voted?(@evidence)
      respond_to do |format|
        format.js { render template: 'votes/vote_denied.js.erb' }
        format.html { redirect_to fact_path(@evidence.fact_id) }
      end
    else
      @vote = Vote.create(vote_params)
      @evidence.fact.update_score

      respond_to do |format|
        format.js {}
        format.html { redirect_to fact_path(@evidence.fact_id), alert: 'Vote Did not Save' }
      end
    end
  end

  def update
  end

  private

  def vote_params
    params.require(:vote).permit(:upvote, :user_id, :evidence_id)

  end

  def load_evidence
    @evidence = Evidence.find(params[:vote][:evidence_id])

  end

  def login_to_vote
    unless current_user
      redirect_to new_user_session_path, alert: "Please log in to Vote!"
    end
  end
end
