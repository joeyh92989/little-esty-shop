class BulkDiscountsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = @merchant.bulk_discounts
    @holidays = (DateService.new).holidays
  end
  def new

    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    big_discount = BulkDiscount.new(bulk_discount_params)

    if big_discount.save
      redirect_to "/merchants/#{@merchant.id}/bulk_discounts"
    else
      redirect_to "/merchants/#{@merchant.id}/bulk_discounts/new"
      flash[:alert] = "Error: #{error_message(big_discount.errors)}"
    end
  end

  private

  def bulk_discount_params
    params.permit(:id, :name, :threshold, :discount, :merchant_id)
  end

end