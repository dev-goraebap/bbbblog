Rails.application.routes.draw do
  root "home#index"

  namespace :lab, module: "lab" do
    namespace :modal, module: "modal_example" do
      root "index"
      get "content", to: "content"
      get "lazy-content", to: "lazy_content"
    end
    namespace :modal2, module: "modal_example2" do
      root "index"
      get "content", to: "content"
      get "lazy-content", to: "lazy_content"
    end

    get "image-preview", to: "image_preview_example#index"
  end
end
