class VotesController < ApplicationController
  before_action :login_to_vote
  before_action :load_evidence, only: [:create]

  def create
    if current_user.already_voted?(@evidence)
      respond_to do |format|
        format.js { render template: 'votes/vote_denied.js.erb', locals: {message: 'You cannot cast more than one vote per piece of evidence!'} }
        format.html { redirect_to fact_path(@evidence.fact_id) }
      end
      block_vote = true #If vote fails, block saving of vote
    end

    if current_user == @evidence.user
      respond_to do |format|
        format.js { render template: 'votes/vote_denied.js.erb', locals: {message: 'You cannot vote on evidence that you submitted!'} }
        format.html { redirect_to fact_path(@evidence.fact_id) }
      end
      block_vote = true #If vote fails, block saving of vote
    end

    unless block_vote
      @vote = Vote.new(vote_params)
      @vote.user_id = current_user.id
      @vote.save

      @evidence.fact.update_score

      respond_to do |format|
        format.js { render template: 'votes/vote_updated.js.erb' }
        format.html { redirect_to fact_path(@evidence.fact_id) }
      end
    end

  end

  def update
    @vote = Vote.find(params[:id])
    @vote.toggle(:upvote)
    @evidence = @vote.evidence

    if @vote.save
      respond_to do |format|
        format.js { render template: 'votes/vote_updated.js.erb' }
      end
    else
      redirect_to @vote.evidence.fact, alert: 'Vote did not save'
    end
  end

  def destroy
    @vote = Vote.find(params[:id])
    @vote.destroy
    @evidence = @vote.evidence

    respond_to do |format|
      format.js { render template: 'votes/vote_updated.js.erb' }
    end

  end

  private
  def vote_params
    params.require(:vote).permit(:upvote, :evidence_id)
  end

  def load_evidence
    @evidence = Evidence.find(params[:vote][:evidence_id])
  end

  def login_to_vote
    unless current_user
      redirect_to new_user_session_path, alert: 'Please log in to Vote!'
    end
  end
end
