class ChangeColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :bulk_discounts, :threshhold, :threshold
  end
end
