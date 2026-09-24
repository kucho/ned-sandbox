class InvoicesController < ApplicationController
  def index
    @invoices = current_account.invoices.order(issued_on: :desc)
  end

  def download_all
    return head(:not_found) unless Flipper.enabled?(:invoice_zip_download, current_account)

    zip = InvoiceArchive.new(current_account.invoices.issued).build
    send_data zip, filename: "invoices-#{Date.current.iso8601}.zip", type: "application/zip"
  end
end
