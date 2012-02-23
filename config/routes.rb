Spree::Core::Engine.routes.append do
  namespace :admin do
    resources :stores
  end
end
