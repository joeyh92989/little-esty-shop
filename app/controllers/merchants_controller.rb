class MerchantsController < ApplicationController

  def show
  end

  def update
    merchant = Merchant.find(params[:id])
    if merchant.update(merchant_params)
      redirect_to "/admin/merchants/#{merchant.id}",
      notice: "successfully updated!"
    else
      redirect_to "/admin/merchants/#{merchant.id}/edit",
      alert: "Error: #{error_message(merchant.errors)}"
    end
  end

  private

  def merchant_params
    params.permit(:id, :name)
  end
end
