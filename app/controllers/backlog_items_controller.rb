class BacklogItemsController < ApplicationController

  # GET /backlog_items
  # GET /backlog_items.json
  def index
    @search = BacklogItem.new_search(params[:search])
    @backlog_items, @backlog_items_count = @search.all, @search.count

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @backlog_items }
    end
  end

  # GET /backlog_items/1
  # GET /backlog_items/1.json
  def show
    @backlog_item = BacklogItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @backlog_item }
    end
  end

  # GET /backlog_items/new
  # GET /backlog_items/new.json
  def new
    @backlog_item = BacklogItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @backlog_item }
    end
  end

  # GET /backlog_items/1/edit
  def edit
    @backlog_item = BacklogItem.find(params[:id])
  end

  # POST /backlog_items
  # POST /backlog_items.json
  def create
    @backlog_item = BacklogItem.new(params[:backlog_item])

    respond_to do |format|
      if @backlog_item.save
        flash[:message] = t('system.successfully_created', :model => t('activerecord.models.backlog_item'))
        format.html { redirect_to(backlog_item_url(@backlog_item)) }
        format.json  { render :json => @backlog_item, :status => :created, :location => @backlog_item }
      else
        format.html { render :action => "new" }
        format.json  { render :json => @backlog_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /backlog_items/1
  # PUT /backlog_items/1.json
  def update
    @backlog_item = BacklogItem.find(params[:id])

    respond_to do |format|
      if @backlog_item.update_attributes(params[:backlog_item])
        flash[:message] = t('system.successfully_updated', :model => t('activerecord.models.backlog_item'))
        format.html { redirect_to(backlog_item_url(@backlog_item)) }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.json  { render :json => @backlog_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /backlog_items/1
  # DELETE /backlog_items/1.json
  def destroy
    @backlog_item = BacklogItem.find(params[:id])
    @backlog_item.destroy

    respond_to do |format|
      flash[:message] = t('system.successfully_destroyed', :model => t('activerecord.models.backlog_item'))
      format.html { redirect_to(backlog_items_url) }
      format.json  { head :ok }
    end
  end

end

