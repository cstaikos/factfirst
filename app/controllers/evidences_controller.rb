class EvidencesController < ApplicationController
  before_action :load_evidence, only: [:upvote, :downvote]

  def upvote
    if current_user.already_voted?(@evidence)
      respond_to do |format|
        format.js { render template: 'evidences/vote_denied.js.erb' }
        format.html { redirect_to fact_path(@evidence.fact_id) }
      end
    else
      Vote.create(upvote: true, user_id: current_user.id, evidence_id: @evidence.id)
      @evidence.fact.update_score #Update score after a vote is cast

      respond_to do |format|
        format.js {}
        format.html { redirect_to fact_path(@evidence.fact_id) }
      end
    end
  end

  def downvote
    if current_user.already_voted?(@evidence)
      respond_to do |format|
        format.js { render template: 'evidences/vote_denied.js.erb' }
        format.html { redirect_to fact_path(@evidence.fact_id) }
      end
    else
      Vote.create(upvote: false, user_id: current_user.id, evidence_id: @evidence.id)
      @evidence.fact.update_score #Update score after a vote is cast

      respond_to do |format|
        format.js {}
        format.html { redirect_to fact_path(@evidence.fact_id) }
      end
    end
  end

  def create
    @fact = Fact.find(params[:fact_id])
    @evidence = @fact.evidences.build(evidence_params)
    @evidence.user = current_user

    if @evidence.save
      redirect_to @fact
    else
      render :fact
    end
  end

  private

  def load_evidence
    @evidence = Evidence.find(params[:id])
  end

  def evidence_params
    params.require(:evidence).permit(:url, :support)
  end
end
