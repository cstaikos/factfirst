class EvidencesController < ApplicationController
  before_action :login_to_add_evidence

  def create
    @fact = Fact.find(params[:fact_id])
    @evidence = @fact.evidences.build(evidence_params)
    @evidence.user = current_user

    evidence_count = @fact.evidences.where(user_id: current_user).count
    if evidence_count <= 5

      begin
        timeout(5) do
          doc = Nokogiri::HTML(open(@evidence.url))

          og_title = doc.css("meta[property='og:title']")
          og_description = doc.css("meta[property='og:description']")

          @evidence.title = og_title.first.attributes["content"] if og_title.length > 0
          @evidence.description = og_description.first.attributes["content"] if og_description.length > 0
        end
      rescue Timeout::Error
        puts 'Timeout error'
      end

      if @evidence.save
        @evidence.votes.create(upvote: true, user: current_user)
        @evidence.fact.update_score
        redirect_to @fact
      else
        flash[:alert] = @evidence.errors.full_messages.to_sentence
        redirect_to fact_path(@fact)
      end

    else
      redirect_to fact_path(@fact), alert: "Evidence not added. You are only permitted 5 evidence submissions per fact!"
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
