Rails.application.routes.draw do
  root to: 'main#index'

  get '/incidents', to: 'incident#index'
end
