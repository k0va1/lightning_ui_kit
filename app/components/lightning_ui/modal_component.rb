# frozen_string_literal: true

class LightningUi::ModalComponent < LightningUi::BaseComponent
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
      controller: "modal",
      modal_target: "dialog"
    }.merge(@options[:data] || {})
  end
end
