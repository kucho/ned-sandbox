class Invoice < ApplicationRecord
  has_many :line_items

  def pdf
    LegacyPdfRenderer.new(self).render
  end

  def preview_lines
    lines = line_items.map(&:to_preview)
    lines << tax_line if Flipper.enabled?(:invoice_preview_tax)
    lines
  end

  private

  def tax_line
    PreviewLine.new(label: "Tax", amount: tax_total)
  end
end
