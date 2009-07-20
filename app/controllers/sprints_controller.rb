class SprintsController < ApplicationController

  # GET /sprints.json
  def index
    @search = Sprint.new_search(params[:search])
    @sprints, @sprints_count = @search.all, @search.count

    respond_to do |format|
      format.json  { render :json => @sprints }
    end
  end

  # GET /sprints/1.json
  def show
    @sprint = Sprint.find(params[:id])

    respond_to do |format|
      format.json  { render :json => @sprint }
    end
  end

  # POST /sprints.json
  def create
    @sprint = Sprint.new(params[:sprint])

    respond_to do |format|
      if @sprint.save
        format.json  { render :json => @sprint, :status => :created, :location => @sprint }
      else
        format.json  { render :json => @sprint.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sprints/1.json
  def update
    @sprint = Sprint.find(params[:id])

    respond_to do |format|
      if @sprint.update_attributes(params[:sprint])
        format.json  { head :ok }
      else
        format.json  { render :json => @sprint.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sprints/1.json
  def destroy
    @sprint = Sprint.find(params[:id])
    @sprint.destroy

    respond_to do |format|
      format.json  { head :ok }
    end
  end

end

