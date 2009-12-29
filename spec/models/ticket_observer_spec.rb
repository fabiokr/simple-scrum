require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TicketObserver do
  before(:each) do
    @product = Factory(:product)
    @sprint = Factory(:sprint, :product => @product)
  end

  it 'should do nothing when ticket has no sprint' do
    ticket = Factory(:ticket, :product => @product)
  end

  it 'should calculate the sprint estimated_velocity after a ticket is created' do
    ticket = Factory(:ticket, :product => @product, :sprint => @sprint)
    @sprint.reload
    @sprint.estimated_velocity.should == ticket.estimative

    ticket2 = Factory(:ticket, :product => @product, :sprint => @sprint)
    @sprint.reload
    @sprint.estimated_velocity.should == ticket.estimative + ticket2.estimative
  end

  it 'should calculate the sprint estimated_velocity after a ticket is destroyed' do
    ticket = Factory(:ticket, :product => @product, :sprint => @sprint)
    @sprint.reload
    @sprint.estimated_velocity.should == ticket.estimative

    ticket2 = Factory(:ticket, :product => @product, :sprint => @sprint)
    @sprint.reload
    @sprint.estimated_velocity.should == ticket.estimative + ticket2.estimative

    ticket.destroy
    @sprint.reload
    @sprint.estimated_velocity.should == ticket2.estimative
  end
end

