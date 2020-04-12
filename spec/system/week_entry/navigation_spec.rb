require 'rails_helper'

describe 'Week Entry Navigation', js: true do
  before { travel_to(Time.zone.local(2020, 1, 7)) }
  after { travel_back }

  it 'moves from week to week' do
    last_week_path = work_week_path('2020-01')
    this_week_path = work_week_path('2020-02')
    next_week_path = work_week_path('2020-03')

    user = FactoryBot.create(:user)
    login_as(user, scope: :user)
    visit this_week_path

    within('main nav') do
      click_link '>'
      expect(page).to have_current_path(next_week_path)
      expect(page).to have_css('p', text: 'Jan 13-17, 2020')
    end

    within('main nav') do
      click_link 'this week'
      expect(page).to have_current_path(this_week_path)
      expect(page).to have_css('p', text: 'Jan 06-10, 2020')
    end

    within('main nav') do
      click_link '<'
      expect(page).to have_current_path(last_week_path)
      expect(page).to have_css('p', text: 'Dec 30, 2019-Jan 03, 2020')
    end
  end
end
