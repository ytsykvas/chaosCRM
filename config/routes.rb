# frozen_string_literal: true

Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check
  get '/change_locale_to_en', to: 'application#change_locale_to_en', as: :change_locale_to_en
  get '/change_locale_to_uk', to: 'application#change_locale_to_uk', as: :change_locale_to_uk

  root 'pages#index'
  devise_for :users
  resources :profiles, only: [] do
    collection do
      get 'customers', to: 'profiles#customers'
      get 'no_last_visit', to: 'profiles#no_last_visit'
      get 'old_last_visit', to: 'profiles#old_last_visit'
    end
  end
  get '/profile', to: 'pages#profile'
end
