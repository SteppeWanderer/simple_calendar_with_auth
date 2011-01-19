class ApplicationController < ActionController::Base
  include ControllerAuthentication
  protect_from_forgery
  
  protected

  def confirm_logged_in
    unless session[:user_id]
      flash[:notice] = "Please log in."
      redirect_to(:controller => 'sessions', :action => 'new')
      return false
    else
      return true
    end
  end
end
