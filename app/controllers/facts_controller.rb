class FactsController < ApplicationController


  before_action :login_to_add_fact, only: [:new, :create]
  before_action :load_fact, only: [:show, :edit, :update, :destroy]


  helper VotesHelper

  def index

    @categories = Category.all
    @facts = Fact.all

    if params[:query] && params[:query].length > 2
      @facts = @facts.where('body ILIKE ?', "%#{params[:query]}%")
    end

    if params[:category]
      if params[:category].downcase == 'favorites'
        @facts = current_user.favorites
      else
        @facts = @facts.where(category: Category.where(name: params[:category]) )
      end
    end

    if params[:sort]
      case params[:sort].downcase
      when 'debated'
        @facts = @facts.sort_by(&:controversy_score) #TODO this too needs to be a db column...sorting this way is way slower
      when 'new'
        @facts = @facts.order(created_at: :desc)
      when 'bullshit'
        @facts = @facts.order(score: :asc)
      when 'truth'
        @facts = @facts.order(score: :desc)  
      end
    else
      # Default sort is popular
      @facts = @facts.sort_by(&:total_votes).reverse #TODO this needs to be a db column...sorting this way is way slower
    end


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
    @new_comment = Comment.new
  end

  def create
    @fact = Fact.create(fact_params)

    @fact.user = current_user

    if @fact.save
      # Make sure any evidences attached to a new fact are associated with current user
      @fact.evidences.each do |evidence|
        evidence.user = current_user
        evidence.save
      end

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
    @fact.destroy
    redirect_to facts_url notice: 'Fact Successfully Deleted'
  end

  private

  def fact_params
    params.require(:fact).permit(:body, :user_id, :category_id,
                                 evidences_attributes: [:url, :support])
  end

  def load_fact
    @fact = Fact.find(params[:id])
  end

  def login_to_add_fact
    unless current_user
      redirect_to new_user_session_path, alert: "Please login to add a Fact!"
    end
  end
end
