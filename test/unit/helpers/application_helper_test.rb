require 'test_helper'
require 'action_view/test_case'

class ApplicationHelperTest < ActionView::TestCase

  context 'A call to form_errors_class' do
    setup do
      @result = form_errors_class
    end

    should 'return class=error' do
      assert @result.has_key?(:class)
      assert_equal 'error', @result[:class]
    end
  end

  context 'A call to show_label' do
    setup do
      @result = show_label('system.create')
    end

    should 'return the message with a :' do
      assert_equal "#{I18n.t('system.create')}:", @result
    end
  end

end

