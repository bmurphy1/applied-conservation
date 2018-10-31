Rails.application.routes.draw do
  root 'projects#index'

  resources :projects do
    resources :targets, only: [:new, :index] do
      collection do
        get :edit_all
        put :update_all
      end
    end
    resources :tasks, only: [:new, :index]
  end
  resources :targets, only: [:create, :show, :update, :edit] do
    resources :health_attributes, only: [:new]
  end
  resources :tasks, only: [:create, :show, :update, :edit] do
    put :pickup
    put :done, :archive
  end
  resources :health_attributes
  
  get  '/health_rating_standards/import', to: 'health_rating_standards#import',     as: 'import_health_rating_standards'
  post '/health_rating_standards/import', to: 'health_rating_standards#import_csv', as: ''

  ActiveAdmin.routes(self)
  devise_for :users
end
