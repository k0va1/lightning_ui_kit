# frozen_string_literal: true

class LightningUiKit::ModalComponent < LightningUiKit::BaseComponent
  renders_one :body
  renders_many :actions

  def initialize(id:, title:, description: nil, open: false, **options)
    @id = id
    @title = title
    @description = description
    @open = open
    @options = options
  end

  def data
    {
      controller: "lui-modal",
      lui_modal_target: "dialog"
    }.merge(@options[:data] || {})
  end
end
