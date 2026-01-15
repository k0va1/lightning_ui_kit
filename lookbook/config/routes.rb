Rails.application.routes.draw do
  get "up" => "rails/health#show", :as => :rails_health_check
  mount Lookbook::Engine, at: "/ui-kit"
end
