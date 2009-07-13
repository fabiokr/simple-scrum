require 'test_helper'
require 'action_view/test_case'

class ButtonHelperTest < ActionView::TestCase
  
  context 'A call to button_tag' do
    setup do
      self.stubs(:icon).returns('icon')
    end
  
    should 'print valid button.' do
      result = button_tag('test', :page)
      assert result.match(/<button>.*<\/button>/)
    end
  end
    
end
