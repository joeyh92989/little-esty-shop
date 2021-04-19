class InvoicesController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_invoices = @merchant.invoices.uniq
  end
  def show 
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:id])
  end
  def update
    binding.pry
    invoice = Invoice.find(params[:id])
    invoice.update(status: params[:status])
    redirect_to "/admin/invoices/#{params[:id]}"
  end
end
