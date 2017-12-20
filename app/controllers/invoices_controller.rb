class InvoicesController < ApplicationController

  before_action :set_invoice, only: [:destroy]
  before_action :set_services, only: [:new]

  def new; end

  def create
    @invoice = Invoice.new(invoice_params)
    @invoice.user = current_user
    if @invoice.save
      redirect_to invoices_path, notice: t('invoices.successful_save')
    else
      redirect_to new_invoice_path, alert: @invoice.errors.full_messages.join(', ')
    end
  end

  def destroy
    if @invoice.destroy
      redirect_to invoices_path, notice: t('invoices.successful_destroy')
    else
      redirect_to invoices_path, alert: @invoice.errors.full_messages.join(', ')
    end
  end

  def index
    @invoices = Invoice.all
  end

  private

  def invoice_params
    params.require(:invoice).permit(
      :invoice_nr, :service_id, :user_id, :price, :comment
    )
  end

  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  def set_services
    @services = Service.all
  end
end
