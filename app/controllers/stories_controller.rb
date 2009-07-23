class StoriesController < ApplicationController

  before_filter :get_product

  def get_product
    @product = Product.find(params[:product_id])
  end

  # GET /stories/1/stories
  def index
    @search = @product.stories.search(params[:search])
    @stories = @search.all

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @stories }
    end
  end

  # GET /stories/new
  def new
    @story = Story.new

    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @story }
    end
  end

  # GET /stories/1/edit
  def edit
    @story = Story.find(params[:id])
  end

  # POST /stories
  def create
    @story = Story.new(params[:product])

    respond_to do |format|
      if @story.save
        flash[:message] = t('system.successfully_created', :model => t('activerecord.models.product'))
        format.html { redirect_to(product_url(@story)) }
        format.json  { render :json => @story, :status => :created, :location => @story }
      else
        format.html { render :action => "new" }
        format.json  { render :json => @story.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /stories/1
  def update
    @story = Story.find(params[:id])

    respond_to do |format|
      if @story.update_attributes(params[:product])
        flash[:message] = t('system.successfully_updated', :model => t('activerecord.models.product'))
        format.html { redirect_to(product_url(@story)) }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.json  { render :json => @story.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /stories/1
  def destroy
    @story = Story.find(params[:id])
    @story.destroy

    respond_to do |format|
      flash[:message] = t('system.successfully_destroyed', :model => t('activerecord.models.product'))
      format.html { redirect_to(products_url) }
      format.json  { head :ok }
    end
  end

end

