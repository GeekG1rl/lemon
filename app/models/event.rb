class Event < ActiveRecord::Base
  attr_reader :rates
  attr_reader :calculate_rates
  validates :email_address, presence: true
  validates :email_type, presence: true
  validates :event, presence: true
  validates :timestamp, presence: true

  def self.rates
    types = self.select(:email_type).distinct

    rates = []
    types.each do |t|
      rates << {
        email_type: t.email_type,
        send: self.where(event: 'send', email_type: t.email_type).count,
        open: self.where(event: 'open', email_type: t.email_type).count,
        click: self.where(event: 'click', email_type: t.email_type).count
      }
    end

    self.calculate_rates(rates)
  end

  def self.calculate_rates(rates)
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
      total_events: self.count,
      sent_emails: self.all.group(:event).count["send"],
      clicks: self.all.group(:event).count["click"],
      emails_opened: self.all.group(:event).count["open"],
      rates: self.rates
    }
  end
end