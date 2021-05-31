class Admin::MerchantsController < ApplicationController
  def index
    @enabled_merchants = Merchant.enabled
    @disabled_merchants = Merchant.disabled
    @top_5_merchants_by_revenue = Merchant.top_5_merchants_by_revenue
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def new; end

  def create
    merchant = Merchant.new(merchant_params)

    if merchant.save
      redirect_to '/admin/merchants'
    else
      redirect_to '/admin/merchants/new'
      flash[:alert] = "Error: #{error_message(merchant.errors)}"
    end
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    if merchant.update(merchant_params)
      redirect_to "/admin/merchants/#{merchant.id}",
                  notice: 'successfully updated!'
    else
      redirect_to "/admin/merchants/#{merchant.id}/edit",
                  alert: "Error: #{error_message(merchant.errors)}"
    end
  end

  def update_status
    merchant = Merchant.find(params[:id])
    if params[:status] == 'disable'
      merchant.update(status: 'disabled')
      redirect_to '/admin/merchants',
                  notice: "#{merchant.name} has been disabled!"
    elsif params[:status] == 'enable'
      merchant.update(status: 'enabled')
      redirect_to '/admin/merchants',
                  notice: "#{merchant.name} has been enabled!"
    end
  end

  private

  def merchant_params
    params.permit(:id, :name)
  end
end
