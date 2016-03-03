class EvidencesController < ApplicationController

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

end
