Rails.application.routes.draw do
  resources :services
  resources :service_categories
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  defaults format: :json do
    get "me" => "users#show"

    # Defines the root path route ("/")
    # root "posts#index"
    devise_for :users, path: '', path_names: {
                                  sign_in: 'login',
                                  sign_out: 'logout',
                                  registration: 'signup'
                                },
                      controllers: {
                        sessions: 'users/sessions',
                        registrations: 'users/registrations',
                        passwords: 'users/passwords'
                      }
  end
end
