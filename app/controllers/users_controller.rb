class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :edit, :update, :destory]
  before_action :correct_user?, only: [:show, :edit, :update, :destroy]
  before_action :reportlist, only: [:show]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = "アカウントを作成しました。"
      redirect_to @user
    else 
      flash.now[:danger] = "アカウントの作成に失敗しました。"
      render :new
    end
  end

  def show
    @reports = @user.reports
    count(@user)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "アカウントを編集しました。"
      redirect_to @user
    else
      flash.now[:danger] = "アカウントの編集に失敗しました。"
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "アカウントを削除しました。"
  redirect_to root_url
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :university, :entrance_year, :password, :password_confirmation)
  end
  
  def correct_user?
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to root_url
    end
  end
  
  def reportlist
    @reportlist_1 = current_user.reports.where(["day >= :day_s and day < :day_e", {day_s: current_user.entrance_year * 10000 + 401, day_e: current_user.entrance_year * 10000 + 10401}])
    @reportlist_2 = current_user.reports.where(["day >= :day_s and day < :day_e", {day_s: current_user.entrance_year * 10000 + 10401, day_e: current_user.entrance_year * 10000 + 20401}])
    @reportlist_3 = current_user.reports.where(["day >= :day_s and day < :day_e", {day_s: current_user.entrance_year * 10000 + 20401, day_e: current_user.entrance_year * 10000 + 30401}])
    @reportlist_4 = current_user.reports.where(["day >= :day_s and day < :day_e", {day_s: current_user.entrance_year * 10000 + 30401, day_e: current_user.entrance_year * 10000 + 40401}])
  end
end


