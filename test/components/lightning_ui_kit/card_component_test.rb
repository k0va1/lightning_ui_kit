require "test_helper"

class LightningUiKit::CardComponentTest < ViewComponent::TestCase
  def test_renders_card
    result = render_inline(LightningUiKit::CardComponent.new) do
      "Card content"
    end

    assert_includes result.to_html, "Card content"
    assert_includes result.to_html, "lui:bg-surface"
  end

  def test_renders_with_title_and_description
    result = render_inline(LightningUiKit::CardComponent.new) do |card|
      card.with_title { "Card Title" }
      card.with_description { "A description" }
      "Body"
    end

    assert_includes result.to_html, "Card Title"
    assert_includes result.to_html, "A description"
    assert_includes result.to_html, "Body"
  end

  def test_renders_with_footer
    result = render_inline(LightningUiKit::CardComponent.new) do |card|
      card.with_footer { "Footer content" }
      "Body"
    end

    assert_includes result.to_html, "Footer content"
    assert_includes result.to_html, 'data-slot="card-footer"'
  end

  def test_renders_with_action
    result = render_inline(LightningUiKit::CardComponent.new) do |card|
      card.with_title { "Title" }
      card.with_action { "Action" }
      "Body"
    end

    assert_includes result.to_html, "Action"
    assert_includes result.to_html, 'data-slot="card-action"'
  end

  def test_renders_with_custom_class
    result = render_inline(LightningUiKit::CardComponent.new(class: "lui:max-w-md")) do
      "Content"
    end

    assert_includes result.to_html, "lui:max-w-md"
  end

  def test_uses_data_slots
    result = render_inline(LightningUiKit::CardComponent.new) do |card|
      card.with_title { "Title" }
      card.with_description { "Desc" }
      "Content"
    end

    assert_includes result.to_html, 'data-slot="card-header"'
    assert_includes result.to_html, 'data-slot="card-title"'
    assert_includes result.to_html, 'data-slot="card-description"'
    assert_includes result.to_html, 'data-slot="card-content"'
  end
end
