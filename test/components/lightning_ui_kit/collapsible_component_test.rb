require "test_helper"

class LightningUiKit::CollapsibleComponentTest < ViewComponent::TestCase
  def test_renders_trigger_and_body
    result = render_inline(LightningUiKit::CollapsibleComponent.new) do |collapsible|
      collapsible.with_trigger { "Toggle me" }
      collapsible.with_body { "Hidden content" }
    end

    assert_includes result.to_html, "Toggle me"
    assert_includes result.to_html, "Hidden content"
  end

  def test_wires_stimulus_controller
    result = render_inline(LightningUiKit::CollapsibleComponent.new) do |collapsible|
      collapsible.with_trigger { "t" }
      collapsible.with_body { "b" }
    end

    assert_includes result.to_html, 'data-controller="lui-collapsible"'
    assert_includes result.to_html, "click->lui-collapsible#toggle"
  end

  def test_closed_by_default
    result = render_inline(LightningUiKit::CollapsibleComponent.new) do |collapsible|
      collapsible.with_trigger { "t" }
      collapsible.with_body { "b" }
    end

    assert_includes result.to_html, "lui:grid-rows-[0fr]"
    assert_includes result.to_html, 'data-lui-collapsible-open-value="false"'
  end

  def test_open_when_specified
    result = render_inline(LightningUiKit::CollapsibleComponent.new(open: true)) do |collapsible|
      collapsible.with_trigger { "t" }
      collapsible.with_body { "b" }
    end

    assert_includes result.to_html, "lui:grid-rows-[1fr]"
    assert_includes result.to_html, 'data-lui-collapsible-open-value="true"'
  end
end
