Rails.application.routes.draw do
  get "up" => "rails/health#show", :as => :rails_health_check

  # In production, relative_url_root handles the /ui-kit prefix
  # In development, we mount at /ui-kit directly
  lookbook_mount_path = Rails.application.config.relative_url_root.present? ? "/" : "/ui-kit"
  mount Lookbook::Engine, at: lookbook_mount_path
end
