Rails.application.routes.draw do
  # devise_for :users

  scope "/notes" do
    resources :notes
  end
end
