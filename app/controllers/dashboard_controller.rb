class DashboardController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @top_customers = @merchant.top_5_by_transactions
  end

end
