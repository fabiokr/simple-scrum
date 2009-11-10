class ProductsController < ApplicationController

  before_filter :require_user

  # GET /products
  # GET /products.json
  def index
    @search = Product.search(params[:search])
    @products = @search.paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @products }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        flash[:message] = t('system.successfully_created', :model => t('activerecord.models.product'))
        format.html { redirect_to(products_url) }
        format.js { render :action => "reload_index" }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        flash[:message] = t('system.successfully_updated', :model => t('activerecord.models.product'))
        format.html { redirect_to(products_url) }
        format.js { render :action => "reload_index" }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      flash[:message] = t('system.successfully_destroyed', :model => t('activerecord.models.product'))
      format.html { redirect_to(products_url) }
    end
  end

end

