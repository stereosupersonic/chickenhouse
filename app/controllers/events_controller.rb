class EventsController < ApplicationController
  allow_unauthenticated_access only: %i[index show]
  before_action :resume_session, only: %i[index show]
  def index
    @pagy, @events = pagy(Event.next_events)
  end

  def show
    @event = Event.friendly.find params[:id]
  end
end
