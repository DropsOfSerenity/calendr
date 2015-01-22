require 'rails_helper'

describe Homework, :type => :model do
  describe '.upcoming' do
    it 'returns future homeworks sorted by ascending due date' do
      priority_homework = FactoryGirl.create(:homework, :due_tomorrow)
      never_homework = FactoryGirl.create(:homework, :due_next_year)
      later_homework = FactoryGirl.create(:homework, :due_next_week)

      upcoming = Homework.upcoming

      expect(upcoming).to eq [priority_homework, later_homework, never_homework]
    end

    it 'does not return past homeworks' do
      past_homework = FactoryGirl.create(:homework, :already_past)

      upcoming = Homework.upcoming

      expect(upcoming).to_not include(past_homework)
    end
  end

  describe '.past' do
    it 'returns past homeworks in sorted descending order' do
      way_past_due_homework = FactoryGirl.create(:homework, :already_way_past)
      past_due_homework = FactoryGirl.create(:homework, :already_past)

      past = Homework.past

      expect(past).to eq [past_due_homework, way_past_due_homework]
    end
  end
end
