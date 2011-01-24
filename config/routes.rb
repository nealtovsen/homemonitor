SampleApp::Application.routes.draw do
    resources :sessions, :only => [:new, :create, :destroy]
    resources :users, :only => [:new, :create, :destroy]
    resources :registrations, :only => [:new, :create]

    root              :to => "pages#home"
    match '/contact', :to => 'pages#contact'
    match '/about',   :to => 'pages#about'
    match '/help',    :to => 'pages#help'
    match '/signup',  :to => 'registrations#new'
    match '/signin',  :to => 'sessions#new'
    match '/signout', :to => 'sessions#destroy'

    match '/recent',  :to => 'observations#show'

end
