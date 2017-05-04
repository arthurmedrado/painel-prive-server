require 'api_constraints'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: :json } do
    # scope module: :v1, constraints: ApiConstraints.new(version: 1) do
    #   # Fallback route
    #   match '*a' => 'status#missing_action', via: :all
    # end

    scope module: :v0, constraints: ApiConstraints.new(version: 0, default: true) do
      put  '/token', to: 'api#update_token'
      put '/login', to: 'api#login'
      get '/data', to: 'api#data'

      get  '/mural/after/:timestamp', to: 'mural#latest'
      # Lista de posts do mural
      get  '/mural(/:page)', to: 'mural#index'
      # Criar novo post para o mural
      post '/mural', to: 'mural#create'

      # Fallback route
      match '*a' => 'status#missing_action', via: :all
    end
  end

  # get '/pushes', to: 'pushes#create'
  # get '/pushes', to: 'pushes#index'
  # get '/pushes', to: 'pushes#new'

  # Always redirect to admin section, no matter where the user is actually
  get '/admin', to: redirect(path: '/novidades', subdomain: 'admin'), as: nil

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  match '/logout', to: 'sessions#destroy', via: :all

  get '/fidelidade', to: 'fidelidade#index'
  post '/imagens', to: 'images#create', as: 'add_image'
  delete '/imagens', to: 'images#destroy'
  post '/imagens/upload', to: 'images#upload', as: 'upload_image'

  # Rotas para Novidades
  get '/novidades', to: 'novidades#index'
  post '/novidades', to: 'novidades#create'
  put '/novidades', to: 'novidades#update'
  delete '/novidades', to: 'novidades#destroy'
  
  post '/notificacao', to: 'pushes#create', as: 'pushes'
  delete '/notificacao', to: 'pushes#destroy'
  
  # Rotas para Eventos
  get '/eventos', to: 'eventos#index'
  post '/eventos', to: 'eventos#create'
  put '/eventos', to: 'eventos#update'
  delete '/eventos', to: 'eventos#destroy'

  get '/galerias', to: 'galeries#index'
  post '/galerias', to: 'galeries#create'
  put '/galerias', to: 'galeries#update'
  delete '/galerias', to: 'galeries#destroy'
  
  # Rotas para Parceiros
  get '/parceiros', to: 'parceiros#index'
  post '/parceiros', to: 'parceiros#create'
  put '/parceiros', to: 'parceiros#update'
  delete '/parceiros', to: 'parceiros#destroy'

  # Rotas para Mural
  get '/mural', to: 'mural#index'

  put '/informacoes', to: 'information#update', as: 'update_information'

  root to: 'information#index'
  match '*a', to: 'application#missing_action', via: :all
end
