Rails.application.routes.draw do
 devise_for :users

devise_scope :user do
   authenticated :user do
     root to: 'categories#index', as: :authenticated_root
     resources :categories, only: [:index]
   end


  unauthenticated do
     root 'devise/sessions#new', as: :unauthenticated_root
   end
 end
end
