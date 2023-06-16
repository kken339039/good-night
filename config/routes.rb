Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api, path: '/api/:user_id' do
    resources :sleep_records, only: [], controller: 'sleep_records' do
      collection do
        post :check_in
        post :check_out
      end
    end
  end
end
