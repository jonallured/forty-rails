require 'rails_helper'

describe 'User can upgrade', js: true do
  describe 'Account page' do
    it 'shows the nudge to upgrade' do
      user = FactoryBot.create(:user)
      login_as(user, scope: :user)

      visit '/account'

      expect(page.text).to match 'Please upgrade your account!'
    end
  end
end
