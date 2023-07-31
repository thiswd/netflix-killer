Rails.application.routes.draw do
  root "movies#index"

  resources :movies, only: %i[index]

  resources :users, only: [] do
    resources :rentals, only: [:index, :post]
    get "recomendations", on: :member
  end
end
