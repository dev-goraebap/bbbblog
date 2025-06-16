Rails.application.routes.draw do
  root "home#index"

  namespace :lab, module: "lab" do
    get "modal/test", to: "modal_test#index"
    get "modal/content", to: "modal_test#content"
  end
end
