require 'test_helper'
require 'action_view/test_case'

class ImagesHelperTest < ActionView::TestCase

  context 'The lightbox_image_tag helper' do
    setup do
      @result = lightbox_image_tag('/fakesource', '/fakethumb')
    end

    should 'add class "img_container" to the anchor' do
      assert @result.include?('class="img_container"')
    end

    should 'add rel "lightbox" to the anchor' do
      assert @result.include?('rel="lightbox"')
    end

    should 'create a correct link with image' do
      assert_equal '<a href="/fakesource" rel="lightbox"><img alt="Fakethumb" class="img_container" src="/fakethumb" /></a>', @result
    end
  end

end

