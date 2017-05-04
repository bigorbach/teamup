Rails.application.routes.draw do
  resources :user_sets do
  #   resources :teams
  # end
  #
  # resources :teams do
  #   resources :members
  # end
end

 devise_for :users

devise_scope :user do
   authenticated :user do
     root to: 'user_sets#index', as: :authenticated_root

   end


  unauthenticated do
     root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end
