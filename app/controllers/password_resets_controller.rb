class PasswordResetsController < ApplicationController

  before_filter :load_user_using_perishable_token, :only => [:edit, :update]
  layout 'login'

  def new
    render
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.deliver_password_reset_instructions!
      flash[:notice] = t('app.password_resets.request_sent')
      render :action => :new
    else
      flash[:notice] = t('app.password_resets.not_found')
      render :action => :new
    end
  end

  def edit
    render
  end

  def update
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.save
      flash[:notice] = t('app.password_resets.password_updated')
      redirect_to root_url
    else
      render :action => :edit
    end
  end

  private

  def load_user_using_perishable_token
    @user = User.find_using_perishable_token(params[:id], 1.day)
    if @user.nil?
      flash[:notice] = t('app.password_resets.problem_loading_user')
      redirect_to new_password_reset_url
    end
  end

end

