class UpdateMerchantDefaultStatusToDisabled < ActiveRecord::Migration[5.2]
  def change
    change_column_default :merchants, :status, "disabled"

  end
end
