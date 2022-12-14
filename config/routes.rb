Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  devise_scope :user do
    get '/users/sign_in', to: 'devise/sessions#new'
    delete '/users/sign_out', to: 'devise/sessions#destroy'
  end

  post '/posts/:post_id', to:'comments#create', as: 'create_comment' # 追加
  resources :posts do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end
  resources :users
  root to: "posts#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
