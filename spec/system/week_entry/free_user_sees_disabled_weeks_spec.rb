require 'rails_helper'

describe 'Free user sees disabled weeks', js: true do
  before { travel_to(Time.zone.local(2020, 1, 7)) }

  it 'shows disabled weeks for next week and week before last' do
    last_year_path = work_week_path('2019-52')
    last_week_path = work_week_path('2020-01')
    this_week_path = work_week_path('2020-02')
    next_week_path = work_week_path('2020-03')

    user = FactoryBot.create(:user)
    login_as(user, scope: :user)
    visit this_week_path

    within('main nav') do
      click_link '>'
      expect(page).to have_current_path(next_week_path)
    end

    expect(page).to have_css('.nullWorkWeek', count: 5)

    within('main nav') do
      click_link 'this week'
      expect(page).to have_current_path(this_week_path)
    end

    expect(page).to have_no_css('.nullWorkWeek')

    within('main nav') do
      click_link '<'
      expect(page).to have_current_path(last_week_path)
    end

    expect(page).to have_no_css('.nullWorkWeek')

    within('main nav') do
      click_link '<'
      expect(page).to have_current_path(last_year_path)
    end

    expect(page).to have_css('.nullWorkWeek', count: 5)
  end
end
