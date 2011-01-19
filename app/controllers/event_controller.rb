class EventController < ApplicationController
 
   before_filter :confirm_logged_in
   
  def index
    @event = Event.find(params[:id])
  end

end
