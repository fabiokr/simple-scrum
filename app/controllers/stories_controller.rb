class StoriesController < ApplicationController

  before_filter :get_product

  def get_product
    @product = Product.find(params[:product_id])
  end

  # GET /stories.json
  def index
    @search = @product.stories.all

    respond_to do |format|
      format.json  { render :json => @stories }
    end
  end

  # GET /stories/1.json
  def show
    @story = Story.find(params[:id])

    respond_to do |format|
      format.json  { render :json => @story }
    end
  end

  # POST /stories.json
  def create
    @story = Story.new(params[:story])

    respond_to do |format|
      if @story.save
        format.json  { render :json => @story, :status => :created, :location => @story }
      else
        format.json  { render :json => @story.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /stories/1.json
  def update
    @story = Story.find(params[:id])

    respond_to do |format|
      if @story.update_attributes(params[:story])
        format.json  { head :ok }
      else
        format.json  { render :json => @story.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /stories/1.json
  def destroy
    @story = Story.find(params[:id])
    @story.destroy

    respond_to do |format|
      format.json  { head :ok }
    end
  end

end

