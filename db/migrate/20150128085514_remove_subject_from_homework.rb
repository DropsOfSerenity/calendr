class RemoveSubjectFromHomework < ActiveRecord::Migration
  def change
    remove_column :homeworks, :subject, :string
  end
end
