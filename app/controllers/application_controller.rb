class ApplicationController < ActionController::Base
  include RansackMemory::Concern
  before_action :save_and_load_filters

  protected

  def previous_page
    session[:return_to] ||= request.referer
  end
end
