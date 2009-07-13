class DashboardController < ApplicationController

  # GET /dashboard
  # GET /dashboard.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
    end
  end

end

