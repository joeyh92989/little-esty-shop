class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(item_params[:merchant_id])
  end

  def show
    @item = Item.find(item_params[:id])
    @merchant = Merchant.find(item_params[:merchant_id])
  end

  def edit
    @item = Item.find(item_params[:id])
    @merchant = Merchant.find(item_params[:merchant_id])
  end

  def update
    merchant = Merchant.find(item_params[:merchant_id])
    item = Item.find(item_params[:id])

    if item.update(item_params)
      redirect_to "/merchants/#{merchant.id}/items/#{item.id}",
      notice: "successfully updated!"
    else
      redirect_to "/merchants/#{merchant.id}/items/#{item.id}/edit",
      alert: "Error: #{error_message(item.errors)}"
    end
  end

  private

  def item_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id)
  end
end
