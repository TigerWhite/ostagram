class AdminPagesController < ApplicationController
  include WorkerHelper
  after_action :verify_authorized
  before_action :set_authorize

  def pundit_user
    current_client
  end

  def self.policy_class
    AdminPage
  end


  def main

  end

  def images
    @items= QueueImage.all.order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
  end

  def users

  end

  def startbot
    start_bot
    redirect_to admin_pages_main_path
    return
  end

  def startprocess
    start_workers
    redirect_to admin_pages_main_path
    return
  end

  def unregworkers
    Resque.workers.each {|w| w.unregister_worker}
    redirect_to admin_pages_main_path
    return
  end

  private
  def set_authorize
    authorize AdminPage
  end

end
