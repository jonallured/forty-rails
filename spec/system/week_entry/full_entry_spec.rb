require 'rails_helper'

full_week_data = {
  'monday' => {
    in: '9:00',
    out: '17:00',
    pto: nil,
    adjust: nil,
    total: '8:00'
  },
  'tuesday' => {
    in: nil,
    out: nil,
    pto: '8:00',
    adjust: nil,
    total: '8:00'
  },
  'wednesday' => {
    in: '8:00',
    out: '17:00',
    pto: nil,
    adjust: nil,
    total: '9:00'
  },
  'thursday' => {
    in: '8:00',
    out: '17:00',
    pto: nil,
    adjust: '-1:00',
    total: '8:00'
  },
  'friday' => {
    in: '11:00',
    out: '17:00',
    pto: '1:00',
    adjust: nil,
    total: '7:00'
  }
}

describe 'Full week entry', js: true do
  before { travel_to(Time.zone.local(2020, 1, 7)) }
  after { travel_back }

  it 'computes week total' do
    user = FactoryBot.create(:user)
    login_as(user, scope: :user)

    visit '/today'

    WorkDay.all.each do |work_day|
      day_of_week = work_day.date.strftime('%A').downcase
      data = full_week_data[day_of_week]
      id = work_day.id

      fill_in "#{id}.inTime", with: "#{data[:in]}\n" if data[:in]
      fill_in "#{id}.outTime", with: "#{data[:out]}\n" if data[:out]
      fill_in "#{id}.ptoTime", with: "#{data[:pto]}\n" if data[:pto]
      fill_in "#{id}.adjustTime", with: "#{data[:adjust]}\n" if data[:adjust]

      day_total = page.find(".total_#{id}")
      expect(day_total.text).to eq data[:total]
    end

    expect(page).to have_css('.grand_total', text: '40:00')
    expect(page).to have_css('.pace', text: 'even')
  end
end
