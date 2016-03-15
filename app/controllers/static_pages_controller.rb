class StaticPagesController < ApplicationController
  def home
    @facts = Fact.all

    @popular_facts =  @facts.sort_by(&:total_votes).reverse.first(3)
    @political_facts = @facts.where(category: Category.where(name: "Politics")).first(3)
    @new_facts = @facts.order(created_at: :desc).first(3)
  end

  def about
  end

  def forum
  end
end
