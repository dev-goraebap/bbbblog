Rails.application.routes.draw do
  root "home#index"

  namespace :lab, module: "lab" do
    get "modal/test", to: "modal_test#index"
    get "modal/content", to: "modal_test#content"
    get "modal/lazy-content", to: "modal_test#lazy_content"
  end
end
