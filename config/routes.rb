Rails.application.routes.draw do
  resources :album_tags
  # resources :tags
  # resources :albums
  resources :users, only: [:index, :show, :create] do
    get 'user_album_tags', to: 'album_tags#user_album_tags', as: :user_album_tags
    resources :album_tags, only: [:user_album_tags]

    #random album_dbx_image route
    get 'albums/random_album_id', to: 'albums#random_album_id', as: :random_album_id
    resources :albums, only: [:random_album_id]


    resources :albums, param: :tags, only: [:tags_search] do
          #tags_search route
          get 'tags_search', to: 'albums#tags_search', as: :tags_search
    end
    
    resources :albums, param: :dbx_image_id, only: [:create, :show, :update] do
      resources :tags, only: [:index, :create, :show, :update]
      delete 'destroy_album_tags', to: 'album_tags#destroy_album_tags', as: :destroy_album_tags
      resources :album_tags, only: [:index, :create, :show, :update, :destroy, :destroy_album_tags]
    end
  end
end


# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html