require 'shoulda'
require 'activesupport'
require 'action_view'
require 'test/unit'
require 'icons'
require 'icons_helper'

class IconsTest < Test::Unit::TestCase
  include ActionView::Helpers::TagHelper  
  include Icons::Helper

  context "Icons module " do
    should "add an alias" do
      Icons.alias({ :foo => :bar, :bar => [:foo, :bar]})
      assert Icons.aliases[:foo] == :bar
      assert Icons.aliases[:bar].nil? == false
      assert Icons.aliases[:bar].kind_of?(Array)
    end
  end

  context "Icons helper" do
    setup do
      Icons.alias({ :foo => "bar", :bar => [:foo, :bar]})
    end

    should "display an icon with no alias" do
      assert icon("test") == '<img border="0" height="16" src="/images/icons/silk/test.png" width="16" />'
      assert icon(:test) == '<img border="0" height="16" src="/images/icons/silk/test.png" width="16" />'
    end

    should "display an icon by alias" do
      assert icon(:foo) == '<img border="0" height="16" src="/images/icons/silk/bar.png" width="16" />'
      assert icon(["foo", :fugue]) == '<img border="0" height="16" src="/images/icons/fugue/foo.png" width="16" />'
    end
  end
end
