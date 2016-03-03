class EvidencesController < ApplicationController
  before_action :login_to_add_evidence

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

  def evidence_params
    params.require(:evidence).permit(:url, :support)
  end

  def login_to_add_evidence
    unless current_user
      redirect_to new_user_session_path, alert: "Please log in to add evidence"
    end
  end

end
