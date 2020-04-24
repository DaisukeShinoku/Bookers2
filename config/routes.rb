Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :books
  resources :users, only: [:show,:index, :edit, :update]
  get 'home/about' => 'home#about'
  root to: 'home#top'
end
