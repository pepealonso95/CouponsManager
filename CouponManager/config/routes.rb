
Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: {
    registrations: 'users/registrations' 
  }
  

  devise_scope :user do
    post 'users/registrations/nonAdmin', :to => 'users/registrations#create_non_admin', as: "create_non_admin"
    put 'users/registrations/nonAdmin', :to => 'users/registrations#complete_non_admin_registration', as: "complete_non_admin_registration"
    get 'users/registrations/nonAdmin/:token', :to => 'users/registrations#edit_non_admin', as: 'edit_non_admin'
    get 'users/current', :to => 'users/registrations#get_current_user' 
  end 


  get "promotions/testPromotion" => "promotions#testPromotion"
  get "promotions/evaluate" => "promotions#evaluate"

  resources :users
  resources :organizations
  resources :promotions
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
