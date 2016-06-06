class Event < ActiveRecord::Base
  validates :email_address, presence: true
  validates :email_type, presence: true
  validates :event, presence: true
  validates :timestamp, presence: true

  def self.analytics
    {
      total_events: Event.count,
      sent_emails: Event.all.group(:event).count["send"],
      clicks: Event.all.group(:event).count["click"],
      emails_opened: Event.all.group(:event).count["open"],
      count_by_email_type: Event.all.group(:email_type).count
    }
  end
end