class ApplicationController < ActionController::Base
  protected

  def previous_page
    session[:return_to] ||= request.referer
  end
end
