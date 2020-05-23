require 'rails_helper'

describe "Comped user can't upgrade", js: true do
  describe 'Account page' do
    it 'shows the comped message' do
      user = FactoryBot.create(:user)
      FactoryBot.create(:comped_subscription, user: user)
      login_as(user, scope: :user)

      visit '/account'

      expect(page.text).to match 'You are comped! :heart_eyes:'
    end
  end

  describe 'Upgrade page' do
    it 'redirects to week entry page' do
      user = FactoryBot.create(:user)
      FactoryBot.create(:comped_subscription, user: user)
      login_as(user, scope: :user)

      visit '/upgrade'

      target = TargetSlug.for(Time.zone.today)
      expect(page).to have_current_path(work_week_path(target))
    end
  end
end
