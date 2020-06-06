Rails.application.routes.draw do
  resources :album_tags
  resources :tags
  # resources :albums
  resources :users, only: [:index, :show, :create] do
    resources :albums, param: :dbx_image_id, only: [:create, :show, :update] do
      resources :tags, only: [:index, :create, :show, :update]
      resources :album_tags, only: [:index, :create, :show, :update, :destroy]
    end
  end
end


# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html