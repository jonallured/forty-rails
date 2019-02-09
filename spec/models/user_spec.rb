require 'rails_helper'

describe User do
  it 'does not save when invalid' do
    user = User.create
    expect(user.valid?).to eq false
    expect(user.persisted?).to eq false
  end

  it 'saves when valid' do
    user = User.create(email: 'user@example.com', password: ('sh' * 9))
    expect(user.valid?).to eq true
    expect(user.persisted?).to eq true
  end
end
