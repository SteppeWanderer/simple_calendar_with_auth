class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:login], params[:password])
    if user
      session[:user_id] = user.id
      session[:name] = user.username
      flash[:notice] = "Logged in successfully."
      #redirect_to_target_or_default("/")
      redirect_to_target_or_default(:controller => "calendar", :action => "index")
      else
      flash.now[:error] = "Invalid login or password."
      render :action => 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    session[:name] = nil
    flash[:notice] = "You have been logged out."
    redirect_to "/"
  end
end
