require "test_helper"

class LightningUiKit::SidebarComponentTest < ViewComponent::TestCase
  def test_renders_component
    result = render_inline(LightningUiKit::SidebarComponent.new)

    assert_includes result.to_html, "<div"
  end
end
