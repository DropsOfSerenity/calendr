class Homework < ActiveRecord::Base
  belongs_to :user
  validates :due_date, :presence => true

  def self.upcoming
    where('due_date >= ?', Time.now).order('due_date ASC')
  end

  def self.past
    where('due_date < ?', Time.now).order('due_date DESC')
  end
end
