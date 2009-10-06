require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ApplicationHelper do

  include ApplicationHelper

  it "should return a title containing the app name - controller - action" do
    @controller.should_receive(:controller_name).and_return('products')
    @controller.should_receive(:action_name).and_return('new')

    assert_equal "#{I18n.t('app.name')} &raquo; #{I18n.t('app.products.index')} &raquo; #{I18n.t('app.products.new')}", title
  end

  it "should return a title containing the app name - controller if it is the index action" do
    @controller.should_receive(:controller_name).and_return('products')
    @controller.should_receive(:action_name).and_return('index')

    assert_equal "#{I18n.t('app.name')} &raquo; #{I18n.t('app.products.index')}", title
  end

  it "should return the default form error class" do
    assert_equal 'error', form_errors_class[:class]
  end

  it "should add : to the label" do
    assert_equal "#{I18n.t('system.create')}:", show_label('system.create')
  end

  it "should create a valid link on new_link" do
    self.should_receive(:icon).and_return('icon')

    result = new_link('/link', 'text');
    assert result.match(/<a.*>icontext<\/a>/)
    assert result.match(/.*class="button newLink inline".*/)
    assert result.match(/.*href="\/link".*/)
  end

  it 'should create a valid link on show_link' do
    self.should_receive(:icon).and_return('icon')

    result = show_link('/link');
    assert result.match(/<a.*>icon<\/a>/)
    assert result.match(/.*class="showLink".*/)
    assert result.match(/.*href="\/link".*/)
  end

  it 'should create a valid link on edit_link' do
    self.should_receive(:icon).and_return('icon')

    result = edit_link('/link');
    assert result.match(/<a.*>icon<\/a>/)
    assert result.match(/.*class="editLink".*/)
    assert result.match(/.*href="\/link".*/)
  end

  it 'should create a valid link on delete_link' do
    self.should_receive(:request_forgery_protection_token).and_return('forgery_token')
    self.should_receive(:form_authenticity_token).and_return('authenticity_token')

    result = delete_link('/link')
    assert result.match(/<form.*>.*<\/form>/)
    assert result.match(/.*class="deleteLink inline".*/)
    assert result.match(/<input name="_method" type="hidden" value="delete" \/>/)
    assert result.match(/<input name="forgery_token" type="hidden" value="authenticity_token" \/>/)
    assert result.match(/<input alt=".*" src=".*" title=".*" type="image" \/>/)
  end

  it 'should print valid button' do
    self.should_receive(:icon).and_return('icon')

    result = button_tag('test', :page)
    assert result.match(/<button>.*<\/button>/)
  end

  it "should print breadcrumbs with ul and li" do
    self.should_receive(:link_to).and_return('one')
    self.should_receive(:crumbs).and_return("two#{Breadcrumb.instance.delimiter}three")

    result = breadcrumbs
    assert result.match(/<ul id="breadcrumb">.*<\/ul>/)
    assert result.match(/.*<li>one<\/li><li>two<\/li><li>three<\/li>.*/)
  end

end

