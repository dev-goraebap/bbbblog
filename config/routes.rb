Rails.application.routes.draw do
  root "home#index"

  namespace :lab do
    get "modal-test", to: "modal_test"
    get "modal-content", to: "modal_content"
  end
end
