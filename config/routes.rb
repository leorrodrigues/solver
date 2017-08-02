Rails.application.routes.draw do
  resources :alternatives
  resources :categories
  resources :trees
  resources :children
  resources :nodes
  get 'about/info'

  get 'ahp/base'
  post 'ahp/base'
  get 'ahp/about'
  post 'ahp/execute_ahp'
  get 'welcome/about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"
end
