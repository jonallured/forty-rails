require 'rails_helper'

describe 'Visitor signs up' do
  scenario 'hitting root when not signed in' do
    visit '/'
    expect(page).to have_current_path(new_user_session_path)
  end

  scenario 'signing up' do
    visit '/sign-up'

    user_email = 'user@example.com'
    user_password = 'sh' * 9

    fill_in 'user[email]', with: user_email
    fill_in 'user[password]', with: user_password
    fill_in 'user[password_confirmation]', with: user_password

    click_button 'sign up'

    deliveries = ActionMailer::Base.deliveries
    expect(deliveries.count).to eq 2

    confirm_email, admin_email = deliveries

    expect(confirm_email.to.first).to eq 'user@example.com'
    expect(confirm_email.subject).to match 'Confirmation instructions'
    confirm_link = confirm_email.body.raw_source.match(/href="(?<url>.+?)">/)[:url]

    visit confirm_link
    fill_in 'user[email]', with: user_email
    fill_in 'user[password]', with: user_password
    click_button 'sign in'

    target = TargetSlug.for(Time.zone.today)
    expect(page).to have_current_path(work_week_path(target))

    expect(admin_email.to.first).to eq Forty.config.admin_email
    expect(admin_email.subject).to match 'New User Sign Up!'
    expect(admin_email.body.encoded).to match user_email
  end
end
