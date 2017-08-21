Rails.application.routes.draw do
    get 'options/novaPesquisa'
    post'options/novaPesquisa'
    get 'options/pesquisa'
    post'options/pesquisa'
    root "welcome#index"
    resources :clouds
    resources :options
    resources :identities
    resources :categories
    resources :nodes
    resources :alternatives
    resources :children
    resources :trees
    resources :result

    get 'about/info'
    get 'about/projeto'
    get 'ahp/base'
    post 'ahp/base'
    get 'ahp/about'
    post 'ahp/execute_ahp'
    get 'welcome/about'
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    match '/ahp/renderForm' => 'ahp#renderForm', :via => :post

end
