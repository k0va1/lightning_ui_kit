require "test_helper"

class LightningUiKit::BuilderTest < ActiveSupport::TestCase
  COMPONENT_METHODS = %i[
    alert avatar badge banner button checkbox combobox description_list
    dropdown dropzone file_input input layout link modal pagination
    select sidebar sidebar_link sidebar_section skeleton spinner switch
    table text textarea toast tooltip
  ].freeze

  def test_responds_to_all_component_methods
    builder = LightningUiKit::Builder.new(nil)

    COMPONENT_METHODS.each do |method|
      assert_respond_to builder, method, "Builder should respond to ##{method}"
    end
  end
end
