require "test_helper"

class LightningUiKit::CarouselComponentTest < ViewComponent::TestCase
  def test_renders_slides
    result = render_inline(LightningUiKit::CarouselComponent.new) do |carousel|
      carousel.with_slide { "Slide 1" }
      carousel.with_slide { "Slide 2" }
    end

    assert_includes result.to_html, "Slide 1"
    assert_includes result.to_html, "Slide 2"
    assert_equal 2, result.css('[data-lui-carousel-target="slide"]').size
  end

  def test_wires_controller_and_arrows
    result = render_inline(LightningUiKit::CarouselComponent.new) do |carousel|
      carousel.with_slide { "x" }
    end

    assert_includes result.to_html, 'data-controller="lui-carousel"'
    assert_includes result.to_html, "click->lui-carousel#prev"
    assert_includes result.to_html, "click->lui-carousel#next"
  end

  def test_loop_value
    result = render_inline(LightningUiKit::CarouselComponent.new(loop: true)) do |carousel|
      carousel.with_slide { "x" }
    end

    assert_includes result.to_html, 'data-lui-carousel-loop-value="true"'
  end

  def test_arrows_and_dots_can_be_hidden
    result = render_inline(LightningUiKit::CarouselComponent.new(show_arrows: false, show_dots: false)) do |carousel|
      carousel.with_slide { "x" }
    end

    refute_includes result.to_html, "click->lui-carousel#next"
    refute_includes result.to_html, 'data-lui-carousel-target="dots"'
  end
end
