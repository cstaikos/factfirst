class EvidencesController < ApplicationController
  before_action :login_to_add_evidence

  def create
    @fact = Fact.find(params[:fact_id])
    @evidence = @fact.evidences.build(evidence_params)
    @evidence.user = current_user

    # If user already has 5 evidences on this fact, they can't add more
    if @fact.evidences.where(user_id: current_user).count >= 5
      redirect_to fact_path(@fact), alert: "Evidence not added. You are only permitted 5 evidence submissions per fact!" and return
    end


    # Grab metadata from evidence url - 5 second limit on request, otherwise save empty title/description
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
      # Auto upvote submitted evidence
      @evidence.votes.create(upvote: true, user: current_user)
      @evidence.fact.update_score

      new_source = Source.create_from_url(@evidence.url)
      if new_source
        @evidence.source = new_source
      else
        flash[:alert] = "Error: #{host} seems to be an invalid domain"
        redirect_to fact_path(@fact) and return
      end

      @evidence.save

      redirect_to fact_path(@fact)
    else
      flash[:alert] = @evidence.errors.full_messages.to_sentence
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
