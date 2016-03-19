class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @categories = %w(test test test)
  end

  def metrics
    @user = current_user
    @evidence_voted_on = []
    @facts_voted_on_by_evidence = []
    @evidences_by_category_count = []
    @facts_by_category_count = []
    @votes_by_category_count = []

    @categories = Category.all.pluck('name')
    @facts = @user.facts

    votes_by_user = @user.votes

    votes_by_user.each do |vote|
      @evidence_voted_on << vote.evidence
    end

    @evidence_voted_on.each { |evidence| @facts_voted_on_by_evidence << evidence.fact }

    Category.all.each do |category|
      @facts_by_category_count << category.facts.where(user: @user).count

      @evidences_by_category_count << category.facts.inject(0) {|sum, fact| sum += fact.evidences.where(user: @user).count }

      @votes_by_category_count << category.facts.inject(0) {|sum, fact| sum += fact.votes.where(user: @user).count }
    end

    respond_to do |format|
      format.html {}
      format.json do
        render json: [@categories,
                      @facts_by_category_count,
                      @evidences_by_category_count,
                      @votes_by_category_count
                                ]
      end
    end
  end
end
