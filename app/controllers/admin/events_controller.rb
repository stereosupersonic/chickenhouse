class Admin::EventsController < Admin::BaseController
  before_action :set_admin_event, only: [:show, :edit, :update, :destroy]

  # GET /admin/events
  def index
    @events = Event.order('start_date DESC').paginate :page => params[:page], :per_page => 20
  end

  # GET /admin/events/1
  def show
  end

  # GET /admin/events/new
  def new
    @event = Event.new
  end

  # GET /admin/events/1/edit
  def edit
  end

  # POST /admin/events
  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to admin_events_url, notice: 'Event was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /admin/events/1
  def update
    if @event.update(event_params)
      redirect_to admin_events_url, notice: 'Event was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /admin/events/1
  def destroy
    @event.destroy
    redirect_to admin_events_url, notice: 'Event was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_event
      @event = Event.friendly.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def event_params
      params.require(:event).permit(:title, :content, :user_id, :location, :start_date, :end_date, :all_day)
    end
end
