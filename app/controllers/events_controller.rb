class EventsController < ApplicationController
  allow_unauthenticated_access only: %i[index show]
  before_action :resume_session, only: %i[index show]
  def index
    @pagy, events = pagy(Event.next_events)
    @events = EventPresenter.wrap(events)
  end

  def show
    event = Event.by_slug params[:id]
    @event = EventPresenter.new(event)
  end
end
