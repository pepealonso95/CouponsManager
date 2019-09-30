
Rails.application.routes.draw do
  get "promotions/testPromotion" => "promotions#testPromotion"
  devise_for :users
  resources :users
  resources :organizations
  resources :promotions
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
