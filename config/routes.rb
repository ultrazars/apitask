Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :tasks, except: [:show]
      resources :tags, only: [:index]
    end
  end
end
