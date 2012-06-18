SimpleBlog::Application.routes.draw do
  devise_for :users

  resources :posts do
    resources :comments, :only => [:new, :create]
  end

  root :to => 'posts#index'

  resources :users
  
  resources :comments, :only => [:show, :edit, :update, :destroy]
end
