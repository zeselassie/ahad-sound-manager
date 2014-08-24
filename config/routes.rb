Rails.application.routes.draw do
  get 'songs/index'

  resources :songs
  root to: "songs#index"
end
