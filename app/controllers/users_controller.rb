class UsersController < ApplicationController
  before_filter :require_admin, :except => [:show]
  before_filter :require_user, :only => [:show]

  def index
    @search = User.search(params[:search])
    @users = @search.paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @users }
    end
  end

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @user }
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        flash[:message] = t('system.successfully_created', :model => t('activerecord.models.user'))
        format.html { redirect_to(users_url) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:message] = t('system.successfully_updated', :model => t('activerecord.models.user'))
        format.html { redirect_to(users_url) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])

    if current_user.id != @user.id
      @user.destroy
      msg = t('system.successfully_destroyed', :model => t('activerecord.models.user'))
    else
      msg = t('app.users.cannot_destroy_self')
    end

    respond_to do |format|
      flash[:message] = msg
      format.html { redirect_to(users_url) }
    end
  end
end

