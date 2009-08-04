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

  context 'A call to new_link' do
    setup do
      self.stubs(:icon).returns('icon')
    end

    should 'print valid link' do
      result = new_link('/link', 'text');
      assert result.match(/<a.*>icontext<\/a>/)
      assert result.match(/.*class="button newLink".*/)
      assert result.match(/.*href="\/link".*/)
    end
  end

  context 'A call to show_link' do
    setup do
      self.stubs(:icon).returns('icon')
    end

    should 'print valid link' do
      result = show_link('/link');
      assert result.match(/<a.*>icon<\/a>/)
      assert result.match(/.*class="showLink".*/)
      assert result.match(/.*href="\/link".*/)
    end
  end

  context 'A call to edit_link' do
    setup do
      self.stubs(:icon).returns('icon')
    end

    should 'print valid link' do
      result = edit_link('/link');
      assert result.match(/<a.*>icon<\/a>/)
      assert result.match(/.*class="editLink".*/)
      assert result.match(/.*href="\/link".*/)
    end
  end

  context 'A call to delete_link' do
    setup do
      self.stubs(:request_forgery_protection_token => 'authenticity_token', :form_authenticity_token => '12345')
    end

    should 'print valid link' do
      result = delete_link('/link');
      assert result.match(/<form.*>.*<\/form>/)
      assert result.match(/.*class="deleteLink".*/)
      assert result.match(/<input id="_method" name="_method" type="hidden" value="delete" \/>/)
      assert result.match(/<input id="authenticity_token" name="authenticity_token" type="hidden" value="12345" \/>/)
      assert result.match(/<input alt="delete" src=".*" title="delete" type="image" \/>/)
    end
  end

end

