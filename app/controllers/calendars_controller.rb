class CalendarsController < ApplicationController
  allow_unauthenticated_access

  def show
    events = Event.visible.where(start_date: Time.zone.now.beginning_of_day..).order(:start_date)

    cal = Icalendar::Calendar.new
    cal.x_wr_calname = "Henaheisl e.V. - Kalender"

    events.each do |event|
      cal.event do |e|
        e.uid = "event-#{event.id}@#{request.host}"
        e.summary = event.title
        e.description = event.content&.gsub(/<[^>]+>/, "")
        e.location = event.location if event.location.present?
        e.url = event_url(event)

        if event.all_day?
          e.dtstart = Icalendar::Values::Date.new(event.start_date.to_date)
          e.dtend = Icalendar::Values::Date.new((event.end_date || event.start_date).to_date + 1.day)
        else
          e.dtstart = Icalendar::Values::DateTime.new(event.start_date.utc, "tzid" => "UTC")
          e.dtend = Icalendar::Values::DateTime.new((event.end_date || event.start_date + 1.hour).utc, "tzid" => "UTC")
        end
      end
    end

    response.headers["Content-Type"] = "text/calendar; charset=utf-8"
    response.headers["Content-Disposition"] = 'inline; filename="henaheisl-kalender.ics"'
    render plain: cal.to_ical
  end
end
