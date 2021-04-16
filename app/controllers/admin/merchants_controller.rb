class Admin::MerchantsController < ApplicationController
  def index
    @enabled_merchants = Merchant.enabled
    @disabled_merchants = Merchant.disabled
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end
end
