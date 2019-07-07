Rails.application.routes.draw do
  get 'map', to: "maps#index"
  get 'infecteds', to: 'survivors#infected_locations' # ?lat=latitude&lng=longitude
  get 'infected_survivors', to: 'details#infected_survivors'
  get 'not_infected_survivors', to: 'details# not_infected_survivors'
  get 'average_resources', to: 'details#average_resources_by_survivor'
  get 'points_lost', to: 'details#points_lost_due_to_infected'
  post 'trades', to: 'trades#create'
  post 'report_infection', to: 'infections#create'
  patch 'survivors/:id', to: 'survivors#update'
  resources :survivors, except: :update # disable PUT
  root 'maps#index'
end
