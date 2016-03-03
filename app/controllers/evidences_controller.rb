class EvidencesController < ApplicationController
  before_action :load_evidence

  def upvote
    current_user.votes.each do |vote|
      if vote.evidence_id == @evidence.id
        respond_to do |format|
          format.js { render template: 'evidences/vote_denied.js.erb' }
          format.html { redirect_to fact_path(@evidence.fact_id) }
        end
        return
      end
    end

      Vote.create(upvote: true, user_id: current_user.id, evidence_id: @evidence.id)

      respond_to do |format|
        format.js {}
        format.html { redirect_to fact_path(@evidence.fact_id) }
      end


  end

  def downvote
    current_user.votes.each do |vote|
      if vote.evidence_id == @evidence.id
        respond_to do |format|
          format.js { render template: 'evidences/vote_denied.js.erb' }
          format.html { redirect_to fact_path(@evidence.fact_id) }
        end
        return
      end
    end

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
