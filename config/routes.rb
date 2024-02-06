# frozen_string_literal: true

Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  root 'pages#index'
  devise_for :users
  get '/change_locale_to_en', to: 'application#change_locale_to_en', as: :change_locale_to_en
  get '/change_locale_to_uk', to: 'application#change_locale_to_uk', as: :change_locale_to_uk

  get '/profile', to: 'pages#profile'
end
