require 'rails_helper'

describe WorkWeek do
  describe '.find_or_create_by' do
    let(:user) { FactoryBot.create :user }

    context 'with an invalid year' do
      it 'returns nil' do
        attrs = { user: user, year: 'asdf', number: '1' }
        work_week = WorkWeek.find_or_create_by(attrs)
        expect(work_week).to be_nil
      end
    end

    context 'with an invalid number' do
      it 'returns nil' do
        attrs = { user: user, year: '2017', number: 'asdf' }
        work_week = WorkWeek.find_or_create_by(attrs)
        expect(work_week).to be_nil
      end
    end

    context 'with an existing year and number' do
      it 'returns a WorkWeek with those existing WorkDay records' do
        monday = FactoryBot.create :work_day, user: user, date: '2017-01-02'
        tuesday = FactoryBot.create :work_day, user: user, date: '2017-01-03'
        wednesday = FactoryBot.create :work_day, user: user, date: '2017-01-04'
        thursday = FactoryBot.create :work_day, user: user, date: '2017-01-05'
        friday = FactoryBot.create :work_day, user: user, date: '2017-01-06'

        attrs = { user: user, year: '2017', number: '1' }
        work_week = WorkWeek.find_or_create_by(attrs)

        expect(WorkDay.count).to eq 5
        expect(work_week.work_days).to eq(
          [
            monday,
            tuesday,
            wednesday,
            thursday,
            friday
          ]
        )
      end
    end

    context 'with a new year and number' do
      it 'creates WorkDay records and returns a WorkWeek for them' do
        expect(WorkDay.count).to eq 0
        attrs = { user: user, year: '2017', number: '1' }
        work_week = WorkWeek.find_or_create_by(attrs)
        expect(WorkDay.count).to eq 5
        dates = work_week.work_days.map(&:date).map(&:to_s)
        expect(dates).to eq(
          %w[
            2017-01-02
            2017-01-03
            2017-01-04
            2017-01-05
            2017-01-06
          ]
        )
      end
    end
  end
end
