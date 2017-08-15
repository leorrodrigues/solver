Rails.application.routes.draw do
  resources :clouds
  resources :options
  resources :identities
  resources :categories
  resources :nodes
  resources :alternatives
  resources :children
  resources :trees
  resources :result

  get 'options/thanks'
  get 'about/info'
  get 'ahp/base'
  post 'ahp/base'
  get 'ahp/about'
  post 'ahp/execute_ahp'
  get 'welcome/about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"
  match '/ahp/renderForm' => 'ahp#renderForm', :via => :post

end
