require 'rails_helper'

describe 'Visitor sees sign in' do
  scenario 'hitting root when not signed in' do
    visit '/'
    expect(current_path).to eq new_user_session_path
  end
end
