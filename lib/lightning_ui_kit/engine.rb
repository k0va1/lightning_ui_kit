require "view_component"

module LightningUiKit
  class Engine < ::Rails::Engine
    isolate_namespace LightningUiKit

    config.to_prepare do
      ActiveSupport.on_load(:action_controller_base) do
        helper LightningUiKit::ApplicationHelper
        helper LightningUiKit::HeroiconHelper
        helper LightningUiKit::ComponentHelper
      end
    end
  end
end
