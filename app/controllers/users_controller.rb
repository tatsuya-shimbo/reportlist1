class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :edit, :update, :destory]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = "ユーザを登録しました。"
      redirect_to @user
    else 
      flash.now[:danger] = "ユーザの登録に失敗しました。"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :university, :entrance_year, :password, :password_confirmation)
  end
end
