require 'rails_helper'

feature 'webhooks' do
  context 'email event data' do
    scenario 'capture all email event data' do
      visit '/event'
      expect(page).to have_content 'open rate'
      expect(page).to have_content 'open rate'
      expect(page).to have_content 'open rate'

    end
  end
end