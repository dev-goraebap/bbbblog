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
    get "image-preview-v2", to: "image_preview_v2#index"

    get "image-uploads", to: "image_uploads#index"
    get "image-uploads/new", to: "image_uploads#new"
    get "image-uploads/:id", to: "image_uploads#show"
    post "image-uploads", to: "image_uploads#create"
  end
end
