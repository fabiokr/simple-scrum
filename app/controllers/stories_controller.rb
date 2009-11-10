class StoriesController < ApplicationController

  before_filter :require_user
  before_filter :get_product

  # GET /products/1/stories
  def index
    @search = @product.stories.search(params[:search])
    @stories = @search.all

    respond_to do |format|
      format.html
      format.json { render :json => @stories.all }
    end
  end

  # GET /products/1/stories/1
  def show
    @story = @product.stories.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @story }
    end
  end

  # GET /products/1/stories/new
  def new
    @story = @product.stories.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /products/1/stories/1/edit
  def edit
    @story = @product.stories.find(params[:id])

    respond_to do |format|
      format.html # edit.html.erb
    end
  end

  # POST /products/1/stories
  def create
    @story = @product.stories.new(params[:story])

    respond_to do |format|
      if @story.save
        flash[:message] = t('system.successfully_created', :model => t('activerecord.models.story'))
        format.html { render :action => 'edit' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /products/1/stories/1
  def update
    @story = @product.stories.find(params[:id])

    respond_to do |format|
      if @story.update_attributes(params[:story])
        flash[:message] = t('system.successfully_updated', :model => t('activerecord.models.story'))
      end

      format.html { render :action => "edit" }
    end
  end

  # DELETE /products/1/stories/1
  def destroy
    @story = @product.stories.find(params[:id])
    @story.destroy

    flash[:message] = t('system.successfully_destroyed', :model => t('activerecord.models.story'))

    if request.xhr?
      render :nothing => true
    else
      respond_to do |format|
        format.html { redirect_to(product_stories_url(@product)) }
      end
    end

  end

  private

  def get_product
    @product = Product.find(params[:product_id])
  end

end

