require 'rails_helper'

describe 'User can upgrade', js: true do
  it 'shows zeros for daily totals' do
    user = FactoryBot.create(:user)
    login_as(user, scope: :user)

    visit '/account'

    expect(page.text).to match 'Please upgrade your account!'
  end
end
