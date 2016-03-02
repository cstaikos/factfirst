class EvidencesController < ApplicationController
  before_action :load_evidence

  def create

  end

  def upvote
    Vote.create(upvote: true, user_id: current_user.id, evidence_id: @evidence.id)
    redirect_to fact_path(@evidence.fact_id)

  end

  def downvote
    Vote.create(upvote: false, user_id: current_user.id, evidence_id: @evidence.id)

  end

  private
  def load_evidence
    @evidence = Evidence.find(params[:id])
  end
end
