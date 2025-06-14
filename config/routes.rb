Rails.application.routes.draw do
  root "home#index"

  get "/admin/posts/new", to: "admin/posts#new"
end
