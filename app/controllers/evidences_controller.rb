class EvidencesController < ApplicationController
  before_action :load_evidence

  def upvote
    Vote.create(upvote: true, user_id: current_user.id, evidence_id: @evidence.id)

    respond_to do |format|
      format.js {}
      format.html { redirect_to fact_path(@evidence.fact_id) }
    end
  end

  def downvote
    Vote.create(upvote: false, user_id: current_user.id, evidence_id: @evidence.id)

    respond_to do |format|
      format.js {}
      format.html { redirect_to fact_path(@evidence.fact_id), alert: 'Vote Did not Save' }
    end
  end

  private

  def load_evidence
    @evidence = Evidence.find(params[:id])
  end
end
