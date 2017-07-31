Rails.application.routes.draw do
  resources :caregories
  resources :children
  resources :nodes
  resources :trees
  get 'about/info'

  get 'ahp/base'
  post 'ahp/base'
  get 'ahp/about'
  post 'ahp/execute_ahp'
  get 'welcome/about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"
end
