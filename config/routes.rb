Rails.application.routes.draw do
  root to: 'main#index'

  resources :incidents

  # slack endpoint route
  post '/slack', to: 'slack#create'
  post '/slack/interact', to: 'slack#interact'
end
