class AddCompleteAtToHomework < ActiveRecord::Migration
  def change
    add_column :homeworks, :completed_at, :datetime
  end
end
