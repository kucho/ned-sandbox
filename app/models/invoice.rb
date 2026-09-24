class Invoice < ApplicationRecord
  has_many :line_items

  def pdf
    if Flipper.enabled?(:invoice_pdf_v2)
      InvoicePdf::Pipeline.new(self).render
    else
      LegacyPdfRenderer.new(self).render
    end
  end

  def preview_lines
    line_items.map(&:to_preview)
  end
end
