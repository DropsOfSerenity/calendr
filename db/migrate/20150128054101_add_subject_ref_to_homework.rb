class AddSubjectRefToHomework < ActiveRecord::Migration
  def change
    add_reference :homeworks, :subject, index: true
  end
end
