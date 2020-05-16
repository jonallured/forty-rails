require 'rails_helper'

describe 'User signs in' do
  scenario 'with valid credentials' do
    user = FactoryBot.create :user
    visit '/'
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'sign in'
    expect(current_path).to match 'work_weeks'
  end
end
