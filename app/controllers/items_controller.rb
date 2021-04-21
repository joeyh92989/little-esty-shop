class ItemsController < ApplicationController
  def index
    
    @merchant = Merchant.find(item_params[:merchant_id])
    @enabled_items = Merchant.find(item_params[:merchant_id]).items.enabled
    @disabled_items = Merchant.find(item_params[:merchant_id]).items.disabled
  end

  def show
    @item = Item.find(item_params[:id])
    @merchant = Merchant.find(item_params[:merchant_id])
  end

  def new
    @merchant = Merchant.find(item_params[:merchant_id])
  end

  def create
    item = Item.new(item_params)
    merchant = Merchant.find(item_params[:merchant_id])

    if item.save
      redirect_to "/merchants/#{merchant.id}/items"
    else
      redirect_to "/merchants/#{merchant.id}/items/new"
      flash[:alert] = "Error: #{error_message(item.errors)}"
    end
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

  def update_status
    merchant = Merchant.find(item_params[:merchant_id])
    item = Item.find(item_params[:id])
    if params[:status] == 'disable'
      item.update(status: "disabled")
      redirect_to "/merchants/#{merchant.id}/items",
      notice: "#{item.name} has been disabled!"
    elsif params[:status] == 'enable'
      item.update(status: "enabled")
      redirect_to "/merchants/#{merchant.id}/items",
      notice: "#{item.name} has been enabled!"
    end
  end

  private

  def item_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id)
  end
end
