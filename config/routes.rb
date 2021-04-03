Rails.application.routes.draw do
  # root to: "admin/login"
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  

  scope "/notes" do
    resources :notes
  end
  # authenticated :user do
  #   root 'note#index' #, as: :root #-> if user is logged in
  #   # resources :controller #-> ONLY available for logged in users
  # end

  # unauthenticated :user do
  #   root 'home#index' #, as: :unauthenticated #-> if user is not logged in
  # end
end
