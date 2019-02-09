require 'rails_helper'

describe 'ping' do
  it 'returns pong' do
    get '/ping'
    expect(response.body).to eq 'pong'
  end
end
