class PopoverComponentPreview < Lookbook::Preview
  def default
  end

  # @param position select [top, bottom, left, right]
  def placement(position: "right")
    render_with_template(locals: {position: position})
  end
end
