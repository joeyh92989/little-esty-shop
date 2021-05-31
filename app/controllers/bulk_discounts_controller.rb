class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = @merchant.bulk_discounts
    @holidays = DateService.new.holidays
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])

    big_discount = BulkDiscount.new(
      name: params[:name],
      discount: params[:discount],
      threshold: params[:threshold],
      merchant: @merchant
    )

    if big_discount.save
      redirect_to "/merchants/#{@merchant.id}/bulk_discounts"
    else
      redirect_to "/merchants/#{@merchant.id}/bulk_discounts/new"
      flash[:alert] = "Error: #{error_message(big_discount.errors)}"
    end
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])

    bulk_discount = BulkDiscount.find(params[:id])

    if bulk_discount.update(
      name: params[:name],
      discount: params[:discount],
      threshold: params[:threshold],
      merchant: @merchant
    )
      redirect_to "/merchants/#{@merchant.id}/bulk_discounts/#{bulk_discount.id}"
    else
      redirect_to "/merchants/#{@merchant.id}/bulk_discounts/#{bulk_discount.id}/edit"
      flash[:alert] = "Error: #{error_message(bulk_discount.errors)}"
    end
  end

  def destroy
    bulk_discount = BulkDiscount.find(params[:id])
    BulkDiscount.delete(bulk_discount)
    redirect_to "/merchants/#{params[:merchant_id]}/bulk_discounts"
  end

  private

  def bulk_discount_params
    params.permit(:id, :name, :threshold, :discount, :merchant_id)
  end
end
