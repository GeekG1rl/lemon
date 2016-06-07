class Event < ActiveRecord::Base
  validates :email_address, presence: true
  validates :email_type, presence: true
  validates :event, presence: true
  validates :timestamp, presence: true

  def self.rates
    types = Event.select(:email_type).distinct

    rates = []
    types.each do |t|
      rates << {
        email_type: t.email_type,
        send: Event.where("event = 'send' and email_type = '" + t.email_type + "'").count,
        open: Event.where("event = 'open' and email_type = '" + t.email_type + "'").count,
        click: Event.where("event = 'click' and email_type = '" + t.email_type + "'").count
      }
    end

    rates.each do |r|
      r[:open_rate] = 0.0
      r[:click_rate] = 0.0

      unless r[:send] == 0
        r[:open_rate] = (r[:open] / r[:send].to_f).round(2)
        r[:click_rate] = (r[:click] / r[:send].to_f).round(2)
      end
    end

    rates
  end

  def self.analytics
    {
      total_events: Event.count,
      sent_emails: Event.all.group(:event).count["send"],
      clicks: Event.all.group(:event).count["click"],
      emails_opened: Event.all.group(:event).count["open"],
      rates: Event.rates
    }
  end
end