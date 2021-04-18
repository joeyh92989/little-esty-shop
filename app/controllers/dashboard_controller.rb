class DashboardController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoice_items_not_shipped = @merchant.invoice_items_not_shipped
  end

end
