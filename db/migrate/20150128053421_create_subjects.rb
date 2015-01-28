class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :name
      t.string :color
      t.references :user, index: true

      t.timestamps
    end
    add_index :subjects, [:user_id, :name], :unique => true
  end
end
