require 'rails_helper'

describe 'User can upgrade', js: true do
  it 'shows zeros for daily totals' do
    user = FactoryBot.create(:user)
    FactoryBot.create(:subscription, user: user)
    login_as(user, scope: :user)

    visit '/account'

    expect(page.text).to match 'Thanks for paying me money!!'
  end
end
