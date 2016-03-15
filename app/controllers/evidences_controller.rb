class EvidencesController < ApplicationController
  before_action :login_to_add_evidence

  def create
    @fact = Fact.find(params[:fact_id])
    @evidence = @fact.evidences.build(evidence_params)
    @evidence.user = current_user

    begin
      timeout(5) do
        doc = Nokogiri::HTML(open(@evidence.url))
        @evidence.title =  doc.at_css("title").text
      end
    rescue Timeout::Error
      puts 'Timeout error'
      @evidence.title = @evidence.url
      @evidence.description = @evidence.url
    end


    if @evidence.save
      redirect_to @fact
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
