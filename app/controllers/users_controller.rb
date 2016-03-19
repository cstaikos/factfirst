class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @categories = %w(test test test)
  end

  def metrics
    @evidence_voted_on = []
    @facts_voted_on_by_evidence = []
    @evidences_by_category_count = []
    @facts_by_category_count = []
    @votes_by_category_count = []

    @categories = Category.all.pluck('name')
    @facts = Fact.all.where(user_id: current_user.id)

    votes_by_user = Vote.all.where(user_id: current_user.id)

    votes_by_user.each do |vote|
      @evidence_voted_on << Evidence.find(vote.evidence_id)
    end

    @evidence_voted_on.each { |evidence| @facts_voted_on_by_evidence << Fact.find_by(id: evidence.fact_id) }

    Category.all.each do |category|
      facts_by_category = Fact.all.where(category_id: category.id)
      @facts_by_category_count << @facts.where(category_id: category.id).count

      @evidences_by_category_count << facts_by_category.inject(0) { |sum, fact| sum + fact.evidences.where(user_id: current_user.id).count }

      @votes_by_category_count << @facts_voted_on_by_evidence.count { |fact| fact.category_id == category.id }
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
