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
    @members = @user_set.members
    @team_size = @user_set.team_size
    @teamed = false
    @balance = @user_set.balance
    @team = true
    balance?
  end

  def destroy
    @user_set = UserSet.find(params[:id])
    @user_set.destroy
    flash[:success] = "User Set deleted successfully"
    redirect_to user_sets_path
  end

  def edit
    @user_set = UserSet.find(params[:id])
    @members = @user_set.members
    @team_size = @user_set.team_size
    balance?
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

  def balance?
    if @balance = false
      randomize_teams
    else
      balance_teams
    end
  end
  :balance?

  def randomize_teams
    randomized_members = @members.shuffle
    randomized_teams = randomized_members.in_groups_of(@team_size)
    @teams = randomized_teams
    @teamed = true
    # redirect_to user_set_path(@user_set)
  end

  def balance_teams
    sorted_members = @members.sort{ |a, b| a.skill_strength <=> b.skill_strength }
    balanced_teams = sorted_members.in_groups_of(@team_size, false)
    @teams = balanced_teams
    @teamed = true
    # redirect_to user_set_path(@user_set)
  end

  def user_set_params
    params.require(:user_set).permit(:topic, :team_size, :balance, :skill)
  end

end
