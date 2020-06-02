Rails.application.routes.draw do
  resources :rename_album_tags_columns
  resources :album_tags
  resources :tags
  resources :albums
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
