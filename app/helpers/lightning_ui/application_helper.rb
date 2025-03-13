module LightningUi
  module ApplicationHelper
    def lui_asset_path(file)
      "/lightning_ui-assets/#{file}".gsub("//", "/")
    end
  end
end
