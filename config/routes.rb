SimpleBlog::Application.routes.draw do
  devise_for :users

  resource :admin, :controller => 'admin', :only => :show

  namespace :admin do
    resources :users, :only => :index

    resources :posts, :only => [:index, :show, :edit, :update]
  end
  
  resources :posts do
    resources :comments, :only => [:new, :create]
  end

  root :to => 'posts#index'

  resources :users
  
  resources :comments, :only => [:show, :edit, :update, :destroy]
end
