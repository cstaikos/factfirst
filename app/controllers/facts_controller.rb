class FactsController < ApplicationController

  helper VotesHelper

  before_action :login_to_add_fact, only: [:new, :create]
  before_action :load_fact, only: [:show, :edit, :update, :destroy]

  def index

    @categories = Category.all
    @facts = Fact.all

    if params[:query] && params[:query].length > 2
      @facts = @facts.where('body ILIKE ?', "%#{params[:query]}%")
    end

    if params[:category]
      if params[:category] == 'Favorites'
        @facts = current_user.favorites
      else
        @facts = @facts.where(category: Category.where(name: params[:category]) )
      end
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

      redirect_to fact_path(@fact), notice: 'Fact successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    @fact.update_attributes(fact_params)
    if @fact.save
      redirect_to fact_path(@fact), notice: 'Fact successfully created.'
    else
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
