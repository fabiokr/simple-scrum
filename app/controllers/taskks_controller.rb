class TaskksController < ApplicationController

  before_filter :require_user
  before_filter :get_product_and_sprint

  def show
    @task = @sprint.tasks.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @task }
    end
  end

  def new
    @task = @sprint.tasks.new
    @task.story_id = params[:story_id] unless params[:story_id].nil?

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
    @task = @sprint.tasks.find(params[:id])

    respond_to do |format|
      format.html # edit.html.erb
    end
  end

  def create
    @task = @sprint.tasks.new(params[:taskk])

    respond_to do |format|
      if @task.save
        flash[:message] = t('system.successfully_created', :model => t('activerecord.models.taskk'))
        format.html { render :action => 'edit' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @task = @sprint.tasks.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:taskk])
        flash[:message] = t('system.successfully_updated', :model => t('activerecord.models.taskk'))
      end

      format.html { render :action => "edit" }
    end
  end

  def destroy
    @task = @sprint.tasks.find(params[:id])
    @task.destroy

    flash[:message] = t('system.successfully_destroyed', :model => t('activerecord.models.taskk'))

    if request.xhr?
      render :nothing => true
    else
      respond_to do |format|
        format.html { redirect_to(product_sprint_url(@product, @sprint)) }
      end
    end
  end

  private

  def get_product_and_sprint
    @product = Product.find(params[:product_id])
    @sprint = @product.sprints.find(params[:sprint_id])
  end

end

