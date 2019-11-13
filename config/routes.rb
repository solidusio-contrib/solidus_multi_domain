# frozen_string_literal: true

Spree::Core::Engine.routes.append do
  namespace :admin do
    resources :stores
  end
end
