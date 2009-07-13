class DashboardController < ApplicationController

  # GET /dashboard
  # GET /dashboard.xml
  def show

    respond_to do |format|
      format.html # show.html.erb
      #format.xml  { render :xml => @user }
    end
  end

end

