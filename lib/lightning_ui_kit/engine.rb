require "view_component"

module LightningUiKit
  class Engine < ::Rails::Engine
    isolate_namespace LightningUiKit

    config.autoload_paths = %W[
      #{root}/app/components
      #{root}/app/helpers
    ]

    initializer "lightning_ui_kit.helpers" do
      ActiveSupport.on_load(:action_controller_base) do
        helper LightningUiKit::ApplicationHelper
        helper LightningUiKit::HeroiconHelper
      end
    end
  end
end
