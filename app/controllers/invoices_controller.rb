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

    merchant = Merchant.find(params[:merchant_id])
    invoice = Invoice.find(params[:id])
    invoice_item = InvoiceItem.find(params[:invoice_item])
    invoice_item.update(status: params[:status])
    redirect_to "/merchants/#{merchant.id}/invoices/#{invoice.id}"
  end
end
