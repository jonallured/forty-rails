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
  it 'computes week total' do
    user = FactoryBot.create(:user)
    login_as(user, scope: :user)

    visit '/today'

    WorkDay.all.each do |work_day|
      day_of_week = work_day.date.strftime('%A').downcase
      data = full_week_data[day_of_week]
      prefix = work_day.id

      fill_in "#{prefix}.inTime", with: data[:in] if data[:in]
      fill_in "#{prefix}.outTime", with: data[:out] if data[:out]
      fill_in "#{prefix}.ptoTime", with: data[:pto] if data[:pto]
      fill_in "#{prefix}.adjustTime", with: data[:adjust] if data[:adjust]

      day_total = page.find(".total_#{prefix}")
      expect(day_total.text).to eq data[:total]
    end

    # expect(page).to have_css('.grand_total', text: '40:00')
    # expect(page).to have_css('.pace', text: 'even')
  end
end
