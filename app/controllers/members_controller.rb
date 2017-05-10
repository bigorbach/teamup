class MembersController < ApplicationController

  def new
    @user_set = UserSet.find(params[:user_set_id])
    @member = Member.new 
  end

  def create
    @user_set = UserSet.find(params[:user_set_id])
    @member = Member.new(member_params)
    @member.user_set = @user_set
    @member.user = current_user

    if @member.save
      flash[:success] = 'Member added to Set'
      redirect_to user_set_path(@user_set)
    else
      flash[:errors] = @member.errors.full_messages.join(', ')
      redirect_to user_set_path(@user_set)
     end
   end

  def edit
    @user_set = User_set.find(params[:user_set_id])
    @member = Member.find(params[:id])
  end

  def update
    @user_set = User_set.find(params[:user_set_id])
    @member = Member.find(params[:id])
    @new_member= @member.update_attributes(member_params)
    if @member.save
      flash[:success] = 'Member updated successfully'
      redirect_to user_set_path(@user_set)
    else
      flash[:errors] = @member.errors.full_messages.join(', ')
      render :edit
    end
  end

  def destroy
    @user_set= User_set.find(params[:user_set_id])
    Member.find(params[:id]).destroy
    flash[:success] = "Member deleted successfully"
    redirect_to user_set_path(@user_set)
  end

  def member_params
    params.require(:member).permit(:name, :skill_strength)
  end
end
