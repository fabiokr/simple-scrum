require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MessagesController, 'routes' do
  should_route :get, '/messages', :controller => :messages, :action => :show
end

describe MessagesController do

  integrate_views

  it "should print messages on :show" do
    get :show

    response.should render_template('layouts/_message')
  end

end

