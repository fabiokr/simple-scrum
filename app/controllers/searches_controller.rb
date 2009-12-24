class SearchesController < ApplicationController

  before_filter :require_user

  def show
    if params[:q].nil? || params[:q].size < 3
      @products = []
      @tickets = []
      @sprints = []
      flash[:notice] = t('app.searches.insuficient_query')
    else
      @products = Product.name_or_owner_like(params[:q]).paginate(:page => 1)
      @tickets = Ticket.name_or_description_like(params[:q]).paginate(:page => 1)
      @sprints = Sprint.name_like(params[:q]).paginate(:page => 1)
    end
  end

end

