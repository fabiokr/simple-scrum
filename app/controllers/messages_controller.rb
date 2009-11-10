class MessagesController < ApplicationController

  def show
    respond_to do |format|
      format.html {render :partial => 'layouts/message'}
    end
  end

end

