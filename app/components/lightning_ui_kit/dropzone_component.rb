# frozen_string_literal: true

class LightningUiKit::DropzoneComponent < LightningUiKit::BaseComponent
  include LightningUiKit::Errors

  def initialize(name:, value: nil, label: nil, form: nil, description: nil, multiple: false, accept: nil, disabled: false, placeholder: nil, error: nil, **options)
    @name = name
    @value = value
    @disabled = disabled
    @accept = accept
    @multiple = multiple
    @error = error
    @label = label
    @form = form
    @description = description
    @placeholder = placeholder
    @options = options
  end

  def classes
    merge_classes(["lui:space-y-4 lui:[&>[data-slot=label]+[data-slot=control]]:mt-3 lui:[&>[data-slot=label]+[data-slot=description]]:mt-1 lui:[&>[data-slot=description]+[data-slot=control]]:mt-3 lui:[&>[data-slot=control]+[data-slot=description]]:mt-3 lui:[&>[data-slot=control]+[data-slot=error]]:mt-3 lui:*:data-[slot=label]:font-medium", @options[:class]].compact.join(" "))
  end

  def data
    {controller: "lui-dropzone"}.merge(@options[:data] || {})
  end

  def input_data
    (@options[:input_data] || {}).tap do |data|
      data[:lui_dropzone_target] = "input"
      data[:action] = "dragover->lui-dropzone#activate drop->lui-dropzone#uploadFiles change->lui-dropzone#uploadFiles"
      if has_errors?
        data[:invalid] = "true"
      end
    end
  end

  def label_data
    {slot: "label"}.merge(@options[:label_data] || {}).tap do |data|
      if @disabled
        data[:disabled] = "true"
      end
    end
  end

  def description_data
    {slot: "description"}.merge(@options[:description_data] || {}).tap do |data|
      if @disabled
        data[:disabled] = "true"
      end
    end
  end

  def error_data
    {slot: "error"}.merge(@options[:error_data] || {}).tap do |data|
      if @disabled
        data[:disabled] = "true"
      end
    end
  end
end
