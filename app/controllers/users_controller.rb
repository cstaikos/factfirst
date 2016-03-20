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
                      @votes_by_category_count]
      end
    end
    
  end


end
