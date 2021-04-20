class ItemsController < ApplicationController
  def index
    
    @merchant = Merchant.find(item_params[:merchant_id])

  end

  def show
    @item = Item.find(item_params[:id])
  end

  private

  def item_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id)
  end
end
