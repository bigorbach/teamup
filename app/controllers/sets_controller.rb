class SetsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    @sets = Set.all
  end

  def new
    if current_user.nil?
      flash[:errors] = "Please sign in first."
      redirect_to sets_path
    end
    @set = Set.new
  end

  def create
    if current_user.nil?
      flash[:errors] = "Please sign in first."
      redirect_to sets_path
    else
      @set = Set.new(set_params)
      @set.contributor = current_user
      if @set.save
        flash[:success] = 'Set added successfully'
        redirect_to set_path(@set)
      else
        flash[:errors] = @set.errors.full_messages.join(', ')
        render :new
      end
    end
  end

  def show
    @set = Set.find(params[:id])
    @team = Team.new
    @teams = @set.teams

  end

  def destroy
    @set = Set.find(params[:id])
    @set.destroy
    flash[:success] = "Set deleted successfully"
    redirect_to sets_path
  end

  def edit
    @set = Set.find(params[:id])
  end

  def update
    @set = Set.find(params[:id])
    @new_set = @set.update_attributes(set_params)
    if @set.save
      flash[:success] = 'Set updated successfully'
      redirect_to set_path(@set)
    else
      flash[:errors] = @set.errors.full_messages.join(', ')
      render :edit
    end
  end

  private

  def set_params
    params.require(:set).permit(:topic, :team_size, :balance, :skill)
  end
end
