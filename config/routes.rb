Rails.application.routes.draw do
  root "home#index"

  namespace :lab, module: "lab" do
    get "modal", to: "modal#index"
    get "modal/content", to: "modal#content"
    get "modal/lazy-content", to: "modal#lazy_content"

    get "modal-v2", to: "modal_v2#index"
    get "modal-v2/content", to: "modal_v2#content"
    get "modal-v2/lazy-content", to: "modal_v2#lazy_content"

    get "image-preview", to: "image_preview#index"
  end
end
