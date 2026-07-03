class SheetComponentPreview < Lookbook::Preview
  # @param side select [right, left, top, bottom]
  def default(side: "right")
    render_with_template(locals: {side: side})
  end
end
