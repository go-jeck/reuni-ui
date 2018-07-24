Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'namespaces#index'

  get 'namespace/new' => 'namespaces#new_namespace'
  post 'namespace/new' => 'namespaces#store_new_namespace'
end
