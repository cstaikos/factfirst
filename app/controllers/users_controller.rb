class UsersController < ApplicationController


  def show
    @user = User.find(params[:id])
    @categories = ['test', 'test', 'test']


  end

  def metrics

    @categories = Category.all.pluck('name')

    @facts = Fact.all.where(user_id: current_user.id)

    @facts_by_category_count = []

    @evidences_by_category_count = []

    @votes_by_category_count = []


    Category.all.each do |category|

      facts_by_category = Fact.all.where(category_id: category.id)

      @facts_by_category_count << @facts.where(category_id: category.id).count

      @evidences_by_category_count << facts_by_category.inject(0){|sum, fact| sum + fact.evidences.where(user_id: current_user.id).count}


    end

    respond_to do |format|
      format.html{}
      format.json{ render json: [@categories, @facts_by_category_count, @evidences_by_category_count] }
    end

  end

end
