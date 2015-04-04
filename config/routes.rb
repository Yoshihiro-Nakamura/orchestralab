Rails.application.routes.draw do
  root "top#index"

  get '/concerts/:id' => 'concerts#show'
  get '/orchestras/:id' => 'orchestras#show'
end
