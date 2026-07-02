require "test_helper"

class LightningUiKit::HoverCardComponentTest < ViewComponent::TestCase
  def test_renders_trigger_and_body
    result = render_inline(LightningUiKit::HoverCardComponent.new) do |card|
      card.with_trigger { "Hover me" }
      card.with_body { "Card content" }
    end

    assert_includes result.to_html, "Hover me"
    assert_includes result.to_html, "Card content"
  end

  def test_wires_stimulus_controller
    result = render_inline(LightningUiKit::HoverCardComponent.new) do |card|
      card.with_trigger { "t" }
      card.with_body { "b" }
    end

    assert_includes result.to_html, 'data-controller="lui-hover-card"'
    assert_includes result.to_html, "mouseenter->lui-hover-card#open"
  end

  def test_content_hidden_by_default
    result = render_inline(LightningUiKit::HoverCardComponent.new) do |card|
      card.with_trigger { "t" }
      card.with_body { "b" }
    end

    assert_includes result.to_html, "lui:hidden"
  end

  def test_delays_are_configurable
    result = render_inline(LightningUiKit::HoverCardComponent.new(open_delay: 500, close_delay: 200)) do |card|
      card.with_trigger { "t" }
      card.with_body { "b" }
    end

    assert_includes result.to_html, 'data-lui-hover-card-open-delay-value="500"'
    assert_includes result.to_html, 'data-lui-hover-card-close-delay-value="200"'
  end
end
