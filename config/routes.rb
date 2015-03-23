Rails.application.routes.draw do
  root "top#index"

  get '/concerts/:id' => 'concerts#show'
end
