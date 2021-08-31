Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "sessions#new"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    get "static_pages/home"
    get "static_pages/help"
    get "static_pages/contact"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    resources :users
  end  
end
