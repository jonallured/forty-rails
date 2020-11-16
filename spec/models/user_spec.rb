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

  describe '#can_view?' do
    let(:active_user) { FactoryBot.create :active_user }
    let(:comped_user) { FactoryBot.create :comped_user }
    let(:free_user) { FactoryBot.create :free_user }

    before { travel_to(Time.zone.local(2020, 1, 7)) }
    after { travel_back }

    context 'with this week' do
      let(:year) { '2020' }
      let(:number) { '02' }

      it 'returns true for all users' do
        expect(active_user.can_view?(year, number)).to eq true
        expect(comped_user.can_view?(year, number)).to eq true
        expect(free_user.can_view?(year, number)).to eq true
      end
    end

    context 'with last week' do
      let(:year) { '2020' }
      let(:number) { '01' }

      it 'returns true for all users' do
        expect(active_user.can_view?(year, number)).to eq true
        expect(comped_user.can_view?(year, number)).to eq true
        expect(free_user.can_view?(year, number)).to eq true
      end
    end

    context 'with next week' do
      let(:year) { '2020' }
      let(:number) { '03' }

      it 'returns true for active and comped users but false for free users' do
        expect(active_user.can_view?(year, number)).to eq true
        expect(comped_user.can_view?(year, number)).to eq true
        expect(free_user.can_view?(year, number)).to eq false
      end
    end

    context 'with last year' do
      let(:year) { '2019' }
      let(:number) { '52' }

      it 'returns true for active and comped users but false for free users' do
        expect(active_user.can_view?(year, number)).to eq true
        expect(comped_user.can_view?(year, number)).to eq true
        expect(free_user.can_view?(year, number)).to eq false
      end
    end
  end
end
