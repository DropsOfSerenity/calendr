class Subject < ActiveRecord::Base
  belongs_to :user
  has_many :homeworks

  validates :name, uniqueness: {scope: :user_id}, presence: true
  validates :color, presence: true

  default_scope { order('created_at DESC') }
end
