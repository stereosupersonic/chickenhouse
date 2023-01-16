class EventsController < ApplicationController
  def show
    @event = Event.friendly.find params[:id]
  end

  def index
    @events = Event.next_events.paginate page: params[:page], per_page: 5
  end
end
