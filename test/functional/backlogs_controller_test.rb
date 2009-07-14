require 'test_helper'

class BacklogsControllerTest < ActionController::TestCase

    context 'on GET to :index' do
      setup do
        @backlogs = [Factory(:backlog), Factory(:backlog)].paginate
        @search = Backlog.new_search

        @search.stubs(:all => @backlogs, :count => @backlogs.size)
        Backlog.expects(:new_search => @search)

        get :index
      end

      should_respond_with :success
      should_assign_to(:search) {@search}
      should_assign_to(:backlogs) {@backlogs}
    end

    context "on GET to :new" do
      setup do
        get :new
      end

      should_respond_with :success
    end

    context "on POST to :create" do
      setup do
        @backlog = Factory(:backlog)
        Backlog.expects(:new => @backlog)
        @backlog.expects(:save => true)

        post :create, :backlog => @backlog.attributes
      end

      should_redirect_to('show') {backlog_path(@backlog)}
      should_set_the_flash_to I18n.t('system.successfully_created', :model => I18n.t('activerecord.models.backlog'))
    end

    context "on POST to :create with invalid records" do
      setup do
        @backlog = Factory(:backlog)
        Backlog.expects(:new => @backlog)
        @backlog.expects(:save => false)
        mock_record_invalid(@backlog)

        post :create, :backlog => @backlog.attributes
      end

      should_render_template :new
    end

    context "on GET to :show" do
      setup do
        @backlog = Factory(:backlog)
        Backlog.expects(:find => @backlog)

        get :show, :id => @backlog.id
      end

      should_respond_with :success
      should_assign_to(:backlog) {@backlog}
    end

    context "on GET to :edit" do
      setup do
        @backlog = Factory(:backlog)
        Backlog.expects(:find => @backlog)

        get :edit, :id => @backlog.id
      end

      should_respond_with :success
      should_assign_to(:backlog) {@backlog}
    end

    context "on POST to :update" do
      setup do
        @backlog = Factory(:backlog)
        Backlog.expects(:find => @backlog)
        @backlog.expects(:update_attributes => true)

        post :update, :id => @backlog.id, :backlog => @backlog.attributes
      end

      should_redirect_to('show') {backlog_path(@backlog)}
      should_set_the_flash_to I18n.t('system.successfully_updated', :model => I18n.t('activerecord.models.backlog'))
    end

    context "on POST to :update with invalid records" do
      setup do
        @backlog = Factory(:backlog)
        Backlog.expects(:find => @backlog)
        @backlog.expects(:update_attributes => false)

        post :update, :id => @backlog.id, :backlog => @backlog.attributes
      end

      should_render_template :edit
    end

    context "on DELETE to :destroy" do
      setup do
        @backlog = Factory(:backlog)
        Backlog.expects(:find => @backlog)
        @backlog.expects(:destroy => true)

        delete :destroy, :id => @backlog.id
      end

      should_redirect_to('index') {backlogs_path}
      should_set_the_flash_to I18n.t('system.successfully_destroyed', :model => I18n.t('activerecord.models.backlog'))
    end

end

