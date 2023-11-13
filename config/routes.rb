# frozen_string_literal: true

Rails.application.routes.draw do
  post '/tickets', to: 'tickets#create'
  root 'tickets#index'
  resources :tickets, only: %i[index show]
end
