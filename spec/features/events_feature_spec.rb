require 'rails_helper'

feature 'event data' do
  before :each do
    Event.create(email_address: 'mara@lostmy.name',
                 email_type: 'Shipment',
                 event: 'send',
                 timestamp: 1465328158
                 )
  end

  scenario 'render sent emails' do
    visit '/'
    expect(page).to have_content('sent_emails')
  end

  scenario 'render clicks' do
    visit '/'
    expect(page).to have_content('clicks')
  end

  scenario 'render emails opened' do
    visit '/'
    expect(page).to have_content('emails_opened')
  end

  scenario "calculates open rate for each email type" do
    visit '/'
    expect(page).to have_content('open_rate')
  end

  scenario "calculates click rate for each email type" do
    visit '/'
    expect(page).to have_content('click_rate')
  end

  scenario "calculates analytics for 'Shipment'" do
    visit '/'
    expect(page).to have_content('Shipment')
  end
  
end