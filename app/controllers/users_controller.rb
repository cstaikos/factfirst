class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @categories = %w(test test test)
  end

  def metrics
    @user = current_user
    @evidences_by_category_count = []
    @facts_by_category_count = []
    @votes_by_category_count = []

    @total_evidence_upvotes = @user.evidences.inject(0) {|sum, evidence| sum + evidence.upvotes}
    @total_evidence_downvotes = @user.evidences.inject(0) {|sum, evidence| sum + evidence.downvotes}
    @total_votes = @total_evidence_downvotes + @total_evidence_upvotes
    @evidence_quality = @user.evidence_quality
    @average_fact_score = @user.facts.average(:score).to_f

    @facts_supporting_evidence =@user.facts.inject(0){|sum, fact| sum + fact.evidences.where(support: true).count}
    @facts_refuting_evidence =@user.facts.inject(0){|sum, fact| sum + fact.evidences.where(support: false).count}
    # @user.facts.

    Category.all.each do |category|
      @facts_by_category_count << category.facts.where(user: @user).count

      @evidences_by_category_count << category.facts.inject(0) {|sum, fact| sum += fact.evidences.where(user: @user).count }

      @votes_by_category_count << category.facts.inject(0) {|sum, fact| sum += fact.votes.where(user: @user).count }

    end

    respond_to do |format|
      format.html {}
      format.json do
        render json: [Category.all.pluck('name'),
                      @facts_by_category_count,
                      @evidences_by_category_count,
                      @votes_by_category_count,
                      @total_evidence_upvotes,
                      @total_evidence_downvotes,
                      @evidence_quality,
                      @average_fact_score,
                      @facts_supporting_evidence,
                      @facts_refuting_evidence
                      ]
      end
    end
    
  end


end
