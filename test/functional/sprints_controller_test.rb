require 'test_helper'

class SprintsControllerTest < ActionController::TestCase

    context 'on GET to :index' do
      setup do
        @sprints = [Factory(:sprint), Factory(:sprint)].paginate
        @search = Sprint.new_search

        @search.stubs(:all => @sprints, :count => @sprints.size)
        Sprint.expects(:new_search => @search)

        get :index
      end

      should_respond_with :success
      should_assign_to(:search) {@search}
      should_assign_to(:sprints) {@sprints}
    end

    context "on GET to :new" do
      setup do
        get :new
      end

      should_respond_with :success
    end

    context "on POST to :create" do
      setup do
        @sprint = Factory(:sprint)
        Sprint.expects(:new => @sprint)
        @sprint.expects(:save => true)

        post :create, :sprint => @sprint.attributes
      end

      should_redirect_to('show') {sprint_path(@sprint)}
      should_set_the_flash_to I18n.t('system.successfully_created', :model => I18n.t('activerecord.models.sprint'))
    end

    context "on POST to :create with invalid records" do
      setup do
        @sprint = Factory(:sprint)
        Sprint.expects(:new => @sprint)
        @sprint.expects(:save => false)
        mock_record_invalid(@sprint)

        post :create, :sprint => @sprint.attributes
      end

      should_render_template :new
    end

    context "on GET to :show" do
      setup do
        @sprint = Factory(:sprint)
        Sprint.expects(:find => @sprint)

        get :show, :id => @sprint.id
      end

      should_respond_with :success
      should_assign_to(:sprint) {@sprint}
    end

    context "on GET to :edit" do
      setup do
        @sprint = Factory(:sprint)
        Sprint.expects(:find => @sprint)

        get :edit, :id => @sprint.id
      end

      should_respond_with :success
      should_assign_to(:sprint) {@sprint}
    end

    context "on POST to :update" do
      setup do
        @sprint = Factory(:sprint)
        Sprint.expects(:find => @sprint)
        @sprint.expects(:update_attributes => true)

        post :update, :id => @sprint.id, :sprint => @sprint.attributes
      end

      should_redirect_to('show') {sprint_path(@sprint)}
      should_set_the_flash_to I18n.t('system.successfully_updated', :model => I18n.t('activerecord.models.sprint'))
    end

    context "on POST to :update with invalid records" do
      setup do
        @sprint = Factory(:sprint)
        Sprint.expects(:find => @sprint)
        @sprint.expects(:update_attributes => false)

        post :update, :id => @sprint.id, :sprint => @sprint.attributes
      end

      should_render_template :edit
    end

    context "on DELETE to :destroy" do
      setup do
        @sprint = Factory(:sprint)
        Sprint.expects(:find => @sprint)
        @sprint.expects(:destroy => true)

        delete :destroy, :id => @sprint.id
      end

      should_redirect_to('index') {sprints_path}
      should_set_the_flash_to I18n.t('system.successfully_destroyed', :model => I18n.t('activerecord.models.sprint'))
    end

end

