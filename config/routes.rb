Rails.application.routes.draw do
  root "home#index"

  namespace :lab, module: "lab" do
    namespace :modal, module: "modal_test" do
      get "test", to: "index"
      get "content", to: "content"
      get "lazy-content", to: "lazy_content"
    end
    namespace :modal2, module: "modal_test2" do
      get "test", to: "index"
      get "content", to: "content"
      get "lazy-content", to: "lazy_content"
    end

    get "upload-box/test", to: "upload_box_test#index"
  end
end
