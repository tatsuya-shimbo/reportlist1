class ReportsController < ApplicationController
  before_action :require_user_logged_in
  before_action :data, only: [:new, :create, :edit, :update]
  before_action :correct_user?, only: [:show, :edit, :update, :destroy]
  before_action :reportlist, only: [:show, :new, :edit]
  
  def new
    @report = current_user.reports.build
  end

  def create
    report_params2 = report_params
    report_params2[:day] = report_params[:day_y].to_i * 10000 + report_params[:day_m].to_i * 100 + report_params[:day_d].to_i
    report_params2.delete(:day_y)
    report_params2.delete(:day_m)
    report_params2.delete(:day_d)
    

    @report = current_user.reports.build(report_params2)
    if @report.save
      flash[:success] = "登録しました。"
      redirect_to root_url
    else
      flash.now[:danger] = "登録に失敗しました。"
      render :new
    end
    
    
  end

  def show
  end

  def edit
  end

  def update
    report_params2 = report_params
    report_params2[:day] = report_params[:day_y].to_i * 10000 + report_params[:day_m].to_i * 100 + report_params[:day_d].to_i
    report_params2.delete(:day_y)
    report_params2.delete(:day_m)
    report_params2.delete(:day_d)
    
    if  @report.update(report_params2)
      flash[:success] = "レポートを編集しました。"
      redirect_to root_url
    else
      flash.now[:danger] = "レポートの編集に失敗しました。"
      render :edit 
    end
  end

  

  def destroy
    @report.destroy
    flash[:success] = "レポートを削除しました。"
    redirect_to root_url
  end
  
  private
  
  def report_params
    params.require(:report).permit(:repo, :title, :day_y, :day_m, :day_d, :teaching)
  end
  
  def data
    @year = [] 
    (2000..2030).each do |num|
      add = {name_y: num.to_s + "年", id_y: num}
      @year.push(add)
    end
    
    @month = []
    (1..12).each do |num|
      add = {name_m: num.to_s + "月", id_m: num}
      @month.push(add)
    end
    
    @day = []
    (1..31).each do |num|
      add = {name_d: num.to_s + "日", id_d: num}
      @day.push(add)
    end
  end
  
  def correct_user?
    @report = current_user.reports.find_by(id: params[:id])
    unless @report
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

