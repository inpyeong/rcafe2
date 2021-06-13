Rails.application.routes.draw do
  resources :bulletins
  resources :posts
  root 'welcome#index'
  # get 'welcome/index'
end
