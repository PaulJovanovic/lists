Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users, controllers: { registrations: 'registrations'}
  resources :users, only: [:show, :edit, :update] do
    collection do
      get :thank_you
    end
  end
  resources :categories, only: [:show]
  resources :lists, only: [:new, :index, :show] do
    collection do
      get :empty
    end
  end
  resources :products, only: [:show]

  namespace :admin do
    root to: "lists#index"
    resources :lists
  end

  constraints subdomain: "api" do
    scope module: :api, defaults: { format: :json } do
      namespace :v0 do
        resources :likes, only: [:create, :update]
        resources :lists do
          member do
            post :add_product
          end
          resources :list_items, only: [:show]
        end
        resources :products
        resources :stores do
          collection do
            get :search
          end
        end
        resource :user do
          collection do
            post :like
            post :unlike
          end
        end
      end
    end
  end
end
