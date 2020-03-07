require 'rails_helper'

full_week_data = [
  {
    prefix: 'monday',
    in: '9:00',
    out: '17:00',
    pto: nil,
    adjust: nil,
    total: '8:00'
  },
  {
    prefix: 'tuesday',
    in: nil,
    out: nil,
    pto: '8:00',
    adjust: nil,
    total: '8:00'
  },
  {
    prefix: 'wednesday',
    in: '8:00',
    out: '17:00',
    pto: nil,
    adjust: nil,
    total: '9:00'
  },
  {
    prefix: 'thursday',
    in: '8:00',
    out: '17:00',
    pto: nil,
    adjust: '-1:00',
    total: '8:00'
  },
  {
    prefix: 'friday',
    in: '11:00',
    out: '17:00',
    pto: '1:00',
    adjust: nil,
    total: '7:00'
  }
]

describe 'Full week entry', js: true do
  it 'computes week total' do
    user = FactoryBot.create(:user)
    login_as(user, scope: :user)

    visit '/today'

    full_week_data.each do |day|
      fill_in "#{day[:prefix]}_in", with: day[:in] if day[:in]
      fill_in "#{day[:prefix]}_out", with: day[:out] if day[:out]
      fill_in "#{day[:prefix]}_pto", with: day[:pto] if day[:pto]
      fill_in "#{day[:prefix]}_adjust", with: day[:adjust] if day[:adjust]

      day_total = page.find(".#{day[:prefix]}_total")
      expect(day_total.text).to eq day[:total]
    end

    # expect(page).to have_css('.grand_total', text: '40:00')
    # expect(page).to have_css('.pace', text: 'even')
  end
end
