require 'test_helper'

class BacklogItemsControllerTest < ActionController::TestCase

    context 'on GET to :index' do
      setup do
        @backlog_items = [Factory(:backlog_item), Factory(:backlog_item)].paginate
        @search = BacklogItem.new_search

        @search.stubs(:all => @backlog_items, :count => @backlog_items.size)
        BacklogItem.expects(:new_search => @search)

        get :index
      end

      should_respond_with :success
      should_assign_to(:search) {@search}
      should_assign_to(:backlog_items) {@backlog_items}
    end

    context "on GET to :new" do
      setup do
        get :new
      end

      should_respond_with :success
    end

    context "on POST to :create" do
      setup do
        @backlog_item = Factory(:backlog_item)
        BacklogItem.expects(:new => @backlog_item)
        @backlog_item.expects(:save => true)

        post :create, :backlog_item => @backlog_item.attributes
      end

      should_redirect_to('show') {backlog_item_path(@backlog_item)}
      should_set_the_flash_to I18n.t('system.successfully_created', :model => I18n.t('activerecord.models.backlog_item'))
    end

    context "on POST to :create with invalid records" do
      setup do
        @backlog_item = Factory(:backlog_item)
        BacklogItem.expects(:new => @backlog_item)
        @backlog_item.expects(:save => false)
        mock_record_invalid(@backlog_item)

        post :create, :backlog_item => @backlog_item.attributes
      end

      should_render_template :new
    end

    context "on GET to :show" do
      setup do
        @backlog_item = Factory(:backlog_item)
        BacklogItem.expects(:find => @backlog_item)

        get :show, :id => @backlog_item.id
      end

      should_respond_with :success
      should_assign_to(:backlog_item) {@backlog_item}
    end

    context "on GET to :edit" do
      setup do
        @backlog_item = Factory(:backlog_item)
        BacklogItem.expects(:find => @backlog_item)

        get :edit, :id => @backlog_item.id
      end

      should_respond_with :success
      should_assign_to(:backlog_item) {@backlog_item}
    end

    context "on POST to :update" do
      setup do
        @backlog_item = Factory(:backlog_item)
        BacklogItem.expects(:find => @backlog_item)
        @backlog_item.expects(:update_attributes => true)

        post :update, :id => @backlog_item.id, :backlog_item => @backlog_item.attributes
      end

      should_redirect_to('show') {backlog_item_path(@backlog_item)}
      should_set_the_flash_to I18n.t('system.successfully_updated', :model => I18n.t('activerecord.models.backlog_item'))
    end

    context "on POST to :update with invalid records" do
      setup do
        @backlog_item = Factory(:backlog_item)
        BacklogItem.expects(:find => @backlog_item)
        @backlog_item.expects(:update_attributes => false)

        post :update, :id => @backlog_item.id, :backlog_item => @backlog_item.attributes
      end

      should_render_template :edit
    end

    context "on DELETE to :destroy" do
      setup do
        @backlog_item = Factory(:backlog_item)
        BacklogItem.expects(:find => @backlog_item)
        @backlog_item.expects(:destroy => true)

        delete :destroy, :id => @backlog_item.id
      end

      should_redirect_to('index') {backlog_items_path}
      should_set_the_flash_to I18n.t('system.successfully_destroyed', :model => I18n.t('activerecord.models.backlog_item'))
    end

end

