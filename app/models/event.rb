class Event < ActiveRecord::Base
  has_event_calendar
  belongs_to :user
end
