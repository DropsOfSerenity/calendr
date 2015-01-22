class CreateHomeworks < ActiveRecord::Migration
  def change
    create_table :homeworks do |t|
      t.string :title
      t.string :subject
      t.string :description
      t.datetime :due_date
      t.references :user, index: true

      t.timestamps
    end
  end
end
