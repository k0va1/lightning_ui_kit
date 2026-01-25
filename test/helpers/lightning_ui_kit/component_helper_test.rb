require "test_helper"

class LightningUiKit::ComponentHelperTest < ActionView::TestCase
  include LightningUiKit::ComponentHelper

  def test_lui_returns_builder
    assert_instance_of LightningUiKit::Builder, lui
  end

  def test_lui_returns_same_builder_instance
    builder1 = lui
    builder2 = lui

    assert_same builder1, builder2
  end
end
