Rails.application.routes.draw do
  root 'bans#index'

  get  'status/:serial_number', to: 'bans#show', as: 'status_link'
  post 'status',                to: 'bans#show'

  namespace :api do
    resources 'health_check', only: %i[index]
  end
end
