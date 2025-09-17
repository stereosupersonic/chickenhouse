class Admin::EventsController < Admin::BaseController
  before_action :set_admin_event, only: %i[show edit update destroy]

  def index
    @pagy, @events = pagy(Event.order(start_date: :desc), limit: 25)
  end

  def show
    @event = EventPresenter.new(@event)
  end

  def new
    @event = Event.new
  end

  def edit; end

  def create
    @event = Event.new event_params.merge(user: Current.user)

    if @event.save
      redirect_to admin_events_url, notice: "Event was successfully created."
    else
      render action: "new"
    end
  end

  def update
    if @event.update event_params.merge(user: Current.user)
      redirect_to admin_events_url, notice: "Event was successfully updated."
    else
      render action: "edit"
    end
  end

  def destroy
    @event.destroy

    redirect_to admin_events_url, notice: "Event was successfully destroyed."
  end

  private

  def set_admin_event
    @event = Event.by_slug params[:id]
  end

  def event_params
    params.require(:event).permit(:title, :old_content, :content, :user_id, :location, :start_date, :end_date, :visible, :all_day)
  end
end
