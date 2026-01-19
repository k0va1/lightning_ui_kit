require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
require "lightning_ui_kit/engine"

module Lookbook
  class Application < Rails::Application
    config.load_defaults Rails::VERSION::STRING.to_f

    # For compatibility with applications that use this config
    config.action_controller.include_all_helpers = false

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])
    config.view_component.preview_paths << File.expand_path("app/previews", Rails.root)
    config.view_component.default_preview_layout = "application"
    config.lookbook.preview_layout = "application"
    config.lookbook.preview_paths << File.expand_path("app/previews", Rails.root)
    config.lookbook.view_component_path = File.expand_path("../app/components", Rails.root)

    config.lookbook.project_logo = File.read(File.expand_path("app/assets/images/logo.svg", Rails.root))
    config.lookbook.ui_theme = "zinc"
    config.lookbook.ui_theme_overrides = {
      header_bg: "oklch(0.141 0.005 285.823)"
    }

    config.lookbook.project_name = "Lightning UI"

    config.lookbook.preview_display_options = {
      body_padding: "20px"
    }

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
