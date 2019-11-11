require 'rails_helper'

describe 'User signs out' do
  scenario 'with valid credentials' do
    # maybe there's a shortcut for signing in that i should use?
    user = FactoryBot.create :user
    visit '/'
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
    visit '/sign-out'
    expect(current_path).to eq new_user_session_path
  end
end
