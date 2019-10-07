
Rails.application.routes.draw do
  # devise_for :users
  get 'healthcheck/check'
  devise_for :user, controllers: {
    registrations: 'users/registrations' 
  }

  
  get "promotions/testPromotion" => "promotions#testPromotion"
  get "promotions/evaluate" => "promotions#evaluate"
  resources :users
  resources :organizations
  resources :promotions
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
