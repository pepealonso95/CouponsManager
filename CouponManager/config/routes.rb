# frozen_string_literal: true

Rails.application.routes.draw do
  resources :transactions
  # devise_for :users
  get 'healthcheck/check'
  devise_for :user, controllers: {
    registrations: 'users/registrations'
  }

  devise_scope :user do
    post 'users/registrations/nonAdmin', to: 'users/registrations#create_non_admin', as: 'create_non_admin'
    put 'users/registrations/nonAdmin', to: 'users/registrations#complete_non_admin_registration', as: 'complete_non_admin_registration'
    get 'users/registrations/nonAdmin/:token', to: 'users/registrations#edit_non_admin', as: 'edit_non_admin'
    get '/users/sign_up' => 'devise/registrations#new'
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  get 'promotions/authorizationCodes' => 'promotions#authorizationCodes'
  post 'promotions/getCode' => 'promotions#getCode'

  get 'promotions/getCode' => 'promotions#viewCode'
  post 'promotions/testToken' => 'promotions#testToken'
  get 'promotions/viewImage' => 'promotions#viewImage'
  get 'promotions/viewReport' => 'promotions#viewReport'

  get 'promotions/new' => 'promotions#new'

  get 'promotions/testPromotion' => 'promotions#testPromotion'
  get 'promotions/evaluate' => 'promotions#evaluate'
  get 'promotions/report' => 'promotions#report'
  get 'promotions/report_rest' => 'promotions#report_rest'
  get 'promotions/filter' => 'promotions#filter'

  resources :users
  resources :organizations
  resources :promotions
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'promotions#index'
end
