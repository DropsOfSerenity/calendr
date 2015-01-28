class Subject < ActiveRecord::Base
  belongs_to :user
  has_many :homeworks

  validates :name, :uniqueness => {scope: :user_id}
end
