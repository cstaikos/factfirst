class EvidencesController < ApplicationController
  before_action :login_to_add_evidence

  def create
    @fact = Fact.find(params[:fact_id])

    # If user already has 5 evidences on this fact, they can't add more
    if @fact.evidences.where(user_id: current_user).count >= 5
      redirect_to fact_path(@fact), alert: "Evidence not added. You are only permitted 5 evidence submissions per fact!" and return
    end

    @evidence = @fact.evidences.build(evidence_params)
    @evidence.user = current_user

    # Auto upvote submitted evidence
    @evidence.votes.build(upvote: true, user: current_user)

    # Create new source or grab existing one if it exists
    @new_source = Source.create_from_url(@evidence.url)

    if @new_source
      @evidence.source = @new_source
    else
      flash[:alert] = "Error: #{URI(@evidence.url).host} seems to be an invalid domain.\nIf you think this is incorrect please contact the admin."
      redirect_to fact_path(@fact) and return
    end

    @evidence.grab_metadata

    if @evidence.save
      @evidence.fact.update_score
      redirect_to fact_path(@fact)
    else
      flash[:alert] = @evidence.errors.full_messages.to_sentence
      @new_source.destroy
      redirect_to fact_path(@fact)
    end

  end

  private

  def evidence_params
    params.require(:evidence).permit(:url, :support)
  end

  def login_to_add_evidence
    unless current_user
      redirect_to new_user_session_path, alert: "Please log in to add Evidence!"
    end
  end

end
