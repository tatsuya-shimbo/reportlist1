class ToppagesController < ApplicationController
  before_action :reportlist
  
  def index
    if logged_in?
      @reports = current_user.reports.order(id: :desc).page(params[:page]).per(25)
    end
  end
  
  def reportlist
    if logged_in?
      @reportlist_1 = current_user.reports.where(["day >= :day_s and day < :day_e", {day_s: current_user.entrance_year * 10000 + 401, day_e: current_user.entrance_year * 10000 + 10401}])
      @reportlist_2 = current_user.reports.where(["day >= :day_s and day < :day_e", {day_s: current_user.entrance_year * 10000 + 10401, day_e: current_user.entrance_year * 10000 + 20401}])
      @reportlist_3 = current_user.reports.where(["day >= :day_s and day < :day_e", {day_s: current_user.entrance_year * 10000 + 20401, day_e: current_user.entrance_year * 10000 + 30401}])
      @reportlist_4 = current_user.reports.where(["day >= :day_s and day < :day_e", {day_s: current_user.entrance_year * 10000 + 30401, day_e: current_user.entrance_year * 10000 + 40401}])
    end
  end
end
