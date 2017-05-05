class UserSetsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    @user_sets = UserSet.all
  end

  def new
    if current_user.nil?
      flash[:errors] = "Please sign in first."
      redirect_to user_sets_path
    end
    @user_set = UserSet.new
    @balance = UserSet::BALANCE

  end

  def create
    if current_user.nil?
      flash[:errors] = "Please sign in first."
      redirect_to user_sets_path
    else
      @user_set = UserSet.new(user_set_params)
      if @user_set.save
        flash[:success] = 'User Set added successfully'
        redirect_to user_set_path(@user_set)
      else
        flash[:errors] = @user_set.errors.full_messages.join(', ')
        render :new
      end
    end
  end

  def show
    @user_set = UserSet.find(params[:id])
    # @team = Team.new
    # @teams = @user_set.teams

  end

  def destroy
    @set = user_set.find(params[:id])
    @user_set.destroy
    flash[:success] = "User Set deleted successfully"
    redirect_to user_sets_path
  end

  def edit
    @user_set = UserSet.find(params[:id])
  end

  def update
    @user_set = UserSet.find(params[:id])
    @new_user_set = @user_set.update_attributes(user_set_params)
    if @user_set.save
      flash[:success] = 'User Set updated successfully'
      redirect_to user_set_path(@user_set)
    else
      flash[:errors] = @user_set.errors.full_messages.join(', ')
      render :edit
    end
  end

  private

  def user_set_params
    params.require(:user_set).permit(:topic, :team_size, :balance, :skill)
  end
end
