Rails.application.routes.draw do
  resources :shortened_urls, only: :index do
    collection do
      get 'shorten_url'
      get 'expand_url'
      get 'analytics'
      get 'user_history'
    end
  end

  get '/oauth2callback', to: 'shortened_urls#oauth2'

  root to: 'shortened_urls#index'
end
