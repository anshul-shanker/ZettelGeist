Rails.application.routes.draw do
  resources :notes
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "notes#index"

  # authenticated :user do
  #   root 'note#index' #, as: :root #-> if user is logged in
  #   # resources :controller #-> ONLY available for logged in users
  # end

  # unauthenticated :user do
  #   root 'home#index' #, as: :unauthenticated #-> if user is not logged in
  # end
end
