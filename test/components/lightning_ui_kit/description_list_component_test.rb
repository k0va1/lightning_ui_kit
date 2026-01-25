require "test_helper"

class LightningUiKit::DescriptionListComponentTest < ViewComponent::TestCase
  def test_renders_component
    result = render_inline(LightningUiKit::DescriptionListComponent.new)

    assert_includes result.to_html, "<dl"
  end
end
