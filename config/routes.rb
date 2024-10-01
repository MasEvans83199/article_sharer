Rails.application.routes.draw do
  devise_for :users

  root 'articles#index'

  resources :users do
    member do
      post 'assign_role'
    end
  end
  
  resources :articles do
    resources :votes, only: [:create, :destroy], defaults: { votable: 'article' }
    resources :comments, only: [:create, :edit, :update,  :destroy] 
      resources :votes, only: [:create, :destroy], defaults: { votable: 'comment' }
  
  end
end
