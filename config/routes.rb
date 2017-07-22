Rails.application.routes.draw do
  resources :shortened_urls, only: :index do
    collection do
      get 'shorten_url'
      get 'expand_url'
      get 'public_analytics'
    end
  end

  root to: 'shortened_urls#index'
end
