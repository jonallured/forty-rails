require 'rails_helper'

describe 'Blank slate view', js: true do
  before { travel_to(Time.zone.local(2020, 1, 7)) }
  after { travel_back }

  it 'shows zeros for daily totals' do
    user = FactoryBot.create(:user)
    login_as(user, scope: :user)

    visit '/today'

    daily_totals = page.all('p.total').map(&:text)
    expect(daily_totals.count).to eq 5
    expect(daily_totals.uniq).to eq ['0:00']

    expect(page).to have_css('.grand_total', text: '0:00')
    expect(page).to have_css('.pace', text: '-16:00')
  end
end
