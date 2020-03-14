require 'rails_helper'

describe WorkDay do
  describe 'uniqueness' do
    context 'attempting to create a duplicate work day for a user' do
      it 'is invalid' do
        user = FactoryBot.create :user
        date = '2017-01-01'

        FactoryBot.create :work_day, user: user, date: date

        duplicate_work_day = FactoryBot.build :work_day, user: user, date: date

        expect(duplicate_work_day).to_not be_valid
      end
    end
  end
end
