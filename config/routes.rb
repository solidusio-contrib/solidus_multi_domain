Rails.application.routes.draw do

  namespace :admin do
    resources :stores
  end

end
