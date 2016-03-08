class FavoritesController < ApplicationController

  before_action :check_login

  def create
    @fact = Fact.find(params[:id])
    @user = current_user

    @user.favorites << @fact
    @user.save

    respond_to do |format|
      format.js { render 'favorite-updated.js.erb'}
      format.html { redirect_to @fact }
    end

  end

  def destroy
    @fact = Fact.find(params[:id])
    @user = current_user

    @user.favorites.delete(@fact)

    respond_to do |format|
      format.js { render 'favorite-updated.js.erb'}
      format.html { redirect_to @fact }
    end
  end

  private

  def check_login
    redirect_to new_user_session_path unless current_user
  end

end
