class UserSessionsController < ApplicationController

  before_filter :require_user, :only => :destroy

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:message] = t('app.login.login_successfull', :user => current_user.login)
      redirect_back_or_default root_path
    else
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    flash[:message] = t('app.login.logout_successfull', :user => current_user.login)
    redirect_back_or_default root_path
  end
end

