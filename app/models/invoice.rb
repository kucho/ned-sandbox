class Invoice < ApplicationRecord
  has_many :line_items

  def pdf
    LegacyPdfRenderer.new(self).render
  end

  def preview_lines
    line_items.map(&:to_preview)
  end
end
