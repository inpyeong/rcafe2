Rails.application.routes.draw do
  resources :posts
  root 'welcome#index'
  # get 'welcome/index'
end
