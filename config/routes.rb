Rails.application.routes.draw do
  get 'map', to: "maps#index"
  get 'infecteds', to: 'survivors#infected_locations' # ?lat=latitude&lng=longitude
  post 'trades', to: 'trades#create'
  post 'report_infection', to: 'infections#create'
  patch 'survivors/:id', to: 'survivors#update'
  resources :survivors, except: :update # disable PUT
end
