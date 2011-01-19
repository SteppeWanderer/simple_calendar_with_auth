class CalendarController < ApplicationController
  
  
  before_filter :confirm_logged_in
   
  def index
    @month = (params[:month] || (Time.zone || Time).now.month).to_i
    @year = (params[:year] || (Time.zone || Time).now.year).to_i
    @shown_month = Date.civil(@year, @month)
    
    @day = (params[:year] || (Time.zone || Time).now.day).to_i
    @ev = Event.where(:user_id => session[:id])
    #u_id = session[:user_id].to_s
    @cond = "events.user_id = " + session[:user_id].to_s
    @event_strips = Event.event_strips_for_month(@shown_month, :conditions => @cond)
    
  end
  
  def new
    @new_event = Event.new
    
  end
  
  def create_event
    @new_event = Event.new(params[:new_event])
    @new_event.user_id = session[:user_id]
    @new_event.start_at = @new_event.end_at
    if @new_event.save
     redirect_to(:action => "index")
   else
     render("new") 
    end
  end
  
  def complex_new
    @new_complex_event = Event.new
    @repeat
    @number
    @everyWeek
    @everyMonth
    @data
    @numberMonth
  end

  def create_complex_event
  @new_complex_event = Event.new(params[:new_complex_event])
  @repeat = params[:repeat].to_i
  @number = params[:number].to_i
  @everyWeek = params[:everyWeek]
  @everyMonth = params[:everyMonth]
  @data = params[:data].to_i
  @numberMonth = params[:numberMonth].to_i
  if @everyWeek
    complex_save(@repeat,@number,@new_complex_event)
  end
  
  if @everyMonth
    complex_save_mon(@numberMonth,@data,@new_complex_event)
  end
  
  redirect_to(:action => "index")
  end
  
  def complex_save(sign, number, event)
    time = Time.now.beginning_of_day
    day_between = time.wday - sign
    end_time = time - day_between.day + 8.day
    number.times do
     ev = Event.create(:name => event.name, :start_at => end_time, :end_at => end_time, :user_id => session[:user_id])
     end_time = end_time + 7.day
    end
 end
 
 def complex_save_mon(months, data, event)
   time = Time.now.beginning_of_month
   end_time = time+data.day#-2.day
   months.times do
    ev = Event.create(:name => event.name, :start_at => end_time, :end_at => end_time, :user_id => session[:user_id])
    end_time = end_time.next_month
   end
 end
 

  
end
