class SprintsController < ApplicationController

  before_filter :require_user
  before_filter :get_product

  # GET /products/1/sprints
  def index
    if params[:search].nil? || params[:search][:order].nil?
      params[:search] ||= {}
      params[:search][:order] ||= 'descend_by_start'
    end

    @search = @product.sprints.search(params[:search])
    @sprints = @search.all

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @sprints.all }
    end
  end

  # GET /products/1/sprints/1
  def show
    @sprint = @product.sprints.find(params[:id])

    @product_sprints = @product.sprints.end_less_than(@sprint.end).paginate(:page => 1, :per_page => 5, :order => 'end DESC')
    @all_products_sprints = Sprint.end_less_than(@sprint.end).product_id_does_not_equal(@product.id).paginate(:page => 1, :per_page => 10, :order => 'end DESC')

    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @sprint }
    end
  end

  # GET /products/1/sprints/new
  def new
    @sprint = @product.sprints.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /products/1/sprints/1/edit
  def edit
    @sprint = @product.sprints.find(params[:id])

    respond_to do |format|
      format.html # edit.html.erb
    end
  end

  # POST /products/1/sprints
  def create
    @sprint = @product.sprints.new(params[:sprint])

    respond_to do |format|
      if @sprint.save
        flash[:message] = t('system.successfully_created', :model => t('activerecord.models.sprint'))
        format.html { render :action => 'edit' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /products/1/sprints/1
  def update
    @sprint = @product.sprints.find(params[:id])

    respond_to do |format|
      if @sprint.update_attributes(params[:sprint])
        flash[:message] = t('system.successfully_updated', :model => t('activerecord.models.sprint'))
        format.html { render :action => 'edit' }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /products/1/sprints/1
  def destroy
    @sprint = @product.sprints.find(params[:id])
    @sprint.destroy

    flash[:message] = t('system.successfully_destroyed', :model => t('activerecord.models.sprint'))

    if request.xhr?
      render :nothing => true
    else
      respond_to do |format|
        format.html { redirect_to(product_sprints_url(@product)) }
      end
    end
  end

  private

  def get_product
    @product = Product.find(params[:product_id])
  end

end

