class CreateBulkDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :bulk_discounts do |t|
      t.integer :threshhold
      t.integer :discount
      t.references :merchant,  foreign_key: true
      t.string :name
      t.timestamps
    end
  end
end
