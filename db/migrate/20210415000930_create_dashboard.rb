class CreateDashboard < ActiveRecord::Migration[5.2]
  def change
    create_table :dashboards do |t|
      t.references :merchant, foreign_key: true
      t.string :name
    end
  end
end
