require 'rails_helper'

describe "Upgraded user can't upgrade", js: true do
  describe 'Account page' do
    it 'shows the thanks message' do
      user = FactoryBot.create(:user)
      FactoryBot.create(:subscription, user: user)
      login_as(user, scope: :user)

      visit '/account'

      expect(page.text).to match 'Thanks for paying me money!!'
    end
  end

  describe 'Upgrade page' do
    it 'redirects to week entry page' do
      user = FactoryBot.create(:user)
      FactoryBot.create(:subscription, user: user)
      login_as(user, scope: :user)

      visit '/upgrade'

      target = TargetSlug.for(Time.zone.today)
      expect(page).to have_current_path(work_week_path(target))
    end
  end
end
