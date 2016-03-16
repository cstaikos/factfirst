class EvidencesController < ApplicationController
  before_action :login_to_add_evidence

  def create
    @fact = Fact.find(params[:fact_id])
    @evidence = @fact.evidences.build(evidence_params)
    @evidence.user = current_user


    evidence_count = @fact.evidences.where(user_id: current_user).count
    if evidence_count <= 5

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

    # Grab host
    host = URI(@evidence.url).host

    # Check if host is a valid domain
    if PublicSuffix.valid?(host)
      domain = PublicSuffix.parse(host).domain
    else
      flash[:alert] = "Error: #{host} seems to be an invalid domain"
      redirect_to fact_path(@fact) and return
    end

    if @evidence.save
      # Auto upvote submitted evidence
      @evidence.votes.create(upvote: true, user: current_user)
      @evidence.fact.update_score

      # Check if source domain exists in DB - if it does, add association - if not, create it and add association
      existing_source = Source.where(domain: domain)
      if existing_source.count > 0
        @evidence.source = existing_source.first
      else
        new_source = Source.create(domain: domain)
        new_source.save
        @evidence.source = new_source
      end

      @evidence.save

      redirect_to @fact

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
