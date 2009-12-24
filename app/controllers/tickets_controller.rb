class TicketsController < ApplicationController

  before_filter :require_user
  before_filter :get_product

  # GET /products/1/tickets
  def index
    if params[:search].nil? || params[:search][:order].nil?
      params[:search] ||= {}
      params[:search][:order] ||= 'descend_by_priority'
    end

    @search = @product.tickets.search(params[:search])
    @tickets = @search.all

    respond_to do |format|
      format.html
      format.json { render :json => @tickets.all }
    end
  end

  # GET /products/1/tickets/1
  def show
    @ticket = @product.tickets.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @ticket }
    end
  end

  # GET /products/1/tickets/new
  def new
    @ticket = @product.tickets.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /products/1/tickets/1/edit
  def edit
    @ticket = @product.tickets.find(params[:id])

    respond_to do |format|
      format.html # edit.html.erb
    end
  end

  # POST /products/1/tickets
  def create
    @ticket = @product.tickets.new(params[:ticket])

    respond_to do |format|
      if @ticket.save
        flash[:message] = t('system.successfully_created', :model => t('activerecord.models.ticket'))
        format.html { redirect_to(edit_product_ticket_path(@product.slug, @ticket)) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /products/1/tickets/1
  def update
    @ticket = @product.tickets.find(params[:id])

    respond_to do |format|
      if @ticket.update_attributes(params[:ticket])
        flash[:message] = t('system.successfully_updated', :model => t('activerecord.models.ticket'))
        format.html { redirect_to(edit_product_ticket_path(@product.slug, @ticket)) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /products/1/tickets/1
  def destroy
    @ticket = @product.tickets.find(params[:id])
    @ticket.destroy

    flash[:message] = t('system.successfully_destroyed', :model => t('activerecord.models.ticket'))

    if request.xhr?
      render :nothing => true
    else
      respond_to do |format|
        format.html { redirect_to(product_tickets_path(@product.slug)) }
      end
    end

  end

  private

  def get_product
    @product = Product.find_by_slug(params[:product_id])
  end

end

