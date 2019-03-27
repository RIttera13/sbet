Rails.application.routes.draw do
  resources :patients, only: [:index, :new, :create, :edit, :update, :destroy]
  root 'patients#index'
end
