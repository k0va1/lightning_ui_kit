require "test_helper"
require "ostruct"

class LightningUiKit::InputOtpComponentTest < ViewComponent::TestCase
  def test_renders_length_slots_plus_hidden
    result = render_inline(LightningUiKit::InputOtpComponent.new(name: :code, length: 4))

    assert_equal 4, result.css('input[data-lui-otp-target="slot"]').size
    assert_equal 1, result.css('input[data-lui-otp-target="hidden"]').size
    assert_includes result.to_html, 'data-controller="lui-otp"'
    assert_includes result.to_html, 'data-lui-otp-length-value="4"'
  end

  def test_hidden_input_name
    result = render_inline(LightningUiKit::InputOtpComponent.new(name: :code, length: 6))

    assert_includes result.to_html, 'name="code"'
  end

  def test_form_prefixes_name
    form = OpenStruct.new(object_name: "user")
    result = render_inline(LightningUiKit::InputOtpComponent.new(name: :otp, form: form, length: 6))

    assert_includes result.to_html, 'name="user[otp]"'
  end

  def test_prefills_digits
    result = render_inline(LightningUiKit::InputOtpComponent.new(name: :code, length: 4, value: "12"))

    slots = result.css('input[data-lui-otp-target="slot"]')
    assert_equal "1", slots[0]["value"]
    assert_equal "2", slots[1]["value"]
  end
end
