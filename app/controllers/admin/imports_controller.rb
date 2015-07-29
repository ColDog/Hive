class Admin::ImportsController < ApplicationController

  def index
  end

  def users
    import = User.import(params[:file])
    flash.now[:success] = 'File imported.'
    @errors = import[:errors]
    @successes = import[:successes]
    render 'index'
  end

  def organizations
    import = Organization.import(params[:file])
    flash.now[:success] = 'File imported.'
    @errors = import[:errors]
    @successes = import[:successes]
    render 'index'
  end


end
