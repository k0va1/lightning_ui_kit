# Fix Lookbook asset routes when mounted at a subpath
# This ensures asset routes match before the catch-all 404 handler
Rails.application.config.after_initialize do
  Lookbook::Engine.routes.prepend do
    get "lookbook-assets/*path", to: "assets#show", as: :lookbook_asset_override
  end
end
