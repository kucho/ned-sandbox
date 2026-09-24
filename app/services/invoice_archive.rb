require "zip"

class InvoiceArchive
  def initialize(invoices)
    @invoices = invoices
  end

  def build
    Zip::OutputStream.write_buffer do |zip|
      @invoices.find_each do |invoice|
        zip.put_next_entry("#{invoice.number}.pdf")
        zip.write(invoice.pdf)
      end
    end.string
  end
end
