require "view_component"
require "stimulus-rails"

module LightningUi
  class Engine < ::Rails::Engine
    isolate_namespace LightningUi

    config.autoload_paths = %W[
      #{root}/app/components
      #{root}/app/helpers
    ]

    initializer "lightning_ui.helpers" do
      ActiveSupport.on_load(:action_controller_base) do
        helper LightningUi::ApplicationHelper
        helper LightningUi::HeroiconHelper
      end
    end
  end
end
