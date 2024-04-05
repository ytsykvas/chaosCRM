# frozen_string_literal: true

Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  get '/change_locale_to_en', to: 'application#change_locale_to_en', as: :change_locale_to_en
  get '/change_locale_to_uk', to: 'application#change_locale_to_uk', as: :change_locale_to_uk

  get '/profile', to: 'pages#profile'
  get 'registrations/create'

  root 'pages#index'
  devise_for :users
  resources :users, only: [:update]
  resources :customers, only: %i[index show edit] do
    collection do
      get 'index', to: 'customers#index'
      get 'no_last_visit', to: 'customers#no_last_visit'
      get 'old_last_visit', to: 'customers#old_last_visit'
      get 'download_xls', to: 'customers#download_xls'
      get 'blocked', to: 'customers#blocked_customers'
    end
    member do
      get 'block'
      get 'visits', to: 'visits#index'
    end
  end

  resource :user_setting, only: [:index] do
    put 'block_customer', on: :member
    put 'unblock_customer', on: :member
  end

  resources :employees, only: %i[index show edit update] do
  end
end
