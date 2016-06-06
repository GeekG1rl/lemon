class EventsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def receive
    fail 'invalid Content-Type' unless request.headers['Content-Type'] == 'application/json'
    data = JSON.parse(request.body.read)

    event = Event.new({
      email_address: data["Address"],
      email_type: data["EmailType"],
      event: data["Event"],
      timestamp: data["Timestamp"]
    })

    event.save

    render nothing: true
  end

  def index
    render nothing: true
  end
end