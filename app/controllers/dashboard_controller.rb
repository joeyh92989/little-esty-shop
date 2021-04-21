class DashboardController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @top_customers = @merchant.top_5_by_transactions
    @merchant_invoice_items = @merchant.items_ready_to_ship
  end

end
