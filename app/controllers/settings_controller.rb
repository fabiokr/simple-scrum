class SettingsController < ApplicationController

  before_filter :require_user

  # GET /settings/edit
  def edit
    @user = current_user

    respond_to do |format|
      format.html # edit.html.erb
    end
  end

  # PUT /update
  def update
    @user = current_user

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:message] = t('system.successfully_updated', :model => t('activerecord.models.settings'))
        format.html { redirect_to(edit_settings_path) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

end

