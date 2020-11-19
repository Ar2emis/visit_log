# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: { registrations: 'registrations' }

  root to: 'courses#index'
  resources :courses, only: %i[new create show destroy edit update] do
    resources :lessons, only: %i[new create]
  end
  resources :lessons, only: %i[edit update destroy] do
    resources :student_lessons, only: %i[create index]
  end
  resources :student_lessons, only: [:update]
  resources :student_courses, only: %i[new create destroy]
end
