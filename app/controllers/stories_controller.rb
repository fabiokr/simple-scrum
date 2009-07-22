class StoriesController < ApplicationController

  before_filter :get_product

  def get_product
    @product = Product.find(params[:product_id])
  end

  # GET /products/1/stories
  # GET /products/1/stories.json
  def index
    @search = Story.search(:product_id_equals => @product.id)
    @stories = @search.all

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @stories }
    end
  end

end

