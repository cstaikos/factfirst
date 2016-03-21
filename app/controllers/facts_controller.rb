class FactsController < ApplicationController
  before_action :login_to_add_fact, only: [:create]


  # before_action :login_to_add_fact, only: [:new, :create]
  before_action :load_fact, only: [:show, :edit, :update, :destroy]
  before_action :load_categories

  helper VotesHelper

  def index

    @facts = Fact.all

    if params[:query] && params[:query].length > 1
      @facts = @facts.where('body ILIKE ?', "%#{params[:query]}%")
    end

    if params[:category]
      if params[:category].downcase == 'favorites'
        @facts = current_user.favorites
      else
        @facts = @facts.where(category: Category.where(name: params[:category]) ) unless params[:category].downcase == 'all'
      end
    end

    if params[:sort]
      case params[:sort].downcase
      when 'debated'
        @facts = @facts.sort_by(&:controversy_score) #TODO this too needs to be a db column...sorting this way is way slower
      when 'new'
        @facts = @facts.order(created_at: :desc)
      when 'false'
        @facts = @facts.order(score: :asc)
      when 'truth'
        @facts = @facts.order(score: :desc)
      end
    else
      # Default sort is popular
      @facts = @facts.sort_by(&:total_votes).reverse #TODO this needs to be a db column...sorting this way is way slower
    end

    @facts = Kaminari.paginate_array(@facts) if @facts.class == Array


    @facts = @facts.page(params[:page]).per(15)

    respond_to do |format|
      format.js {}
      format.html {}
    end

  end

  def new
    @fact = Fact.new

  end

  def show
    @fact = Fact.find(params[:id])
    @evidence = @fact.evidences.build

    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    @fact = Fact.create(fact_params)


    @category = @fact.category_id

    @fact.user = current_user

    if @fact.save
      flash[:notice] = 'Fact successfully created!'
      redirect_to fact_path(@fact)
    else
      flash.now[:alert] = @fact.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
  end

  def update
    @fact.update_attributes(fact_params)
    if @fact.save

      flash[:notice] = 'Fact successfully Updated!'
      redirect_to fact_path(@fact)

    else

      flash.now[:alert] = @fact.errors.full_messages.to_sentence
      render :edit

    end
  end

  def destroy
    if @fact.total_votes > 0
      redirect_to @fact, alert: 'Cannot delete fact that has votes - contact admin if you feel this is necessary'
    else
      @fact.destroy
      redirect_to facts_url notice: 'Fact Successfully Deleted'
    end
  end

  private

  def fact_params
    params.require(:fact).permit(:body, :user_id, :category_id,
                                 evidences_attributes: [:url, :support])
  end

  def load_fact
    @fact = Fact.find(params[:id])
  end

  # def login_to_add_fact
  #   unless current_user
  #     redirect_to new_user_session_path, alert: "Please login to add a Fact!"
  #   end
  # end

  def load_categories
    @categories = Category.all
  end

  def login_to_add_fact
    unless current_user
      redirect_to new_user_session_path, alert: "Please log in to create a fact!"
    end
  end
end
