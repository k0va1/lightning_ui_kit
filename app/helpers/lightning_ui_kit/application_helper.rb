module LightningUiKit
  module ApplicationHelper
    def lui_asset_path(file)
      "/lightning_ui_kit-assets/#{file}".gsub("//", "/")
    end
  end
end
