Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'namespaces#index'

  get 'service/new' => 'services#new_service'
  post 'service/new' => 'services#store_new_service'

  get 'namespace/new' => 'namespaces#new_namespace'
  get 'namespace/:servicename' => 'namespaces#namespace_list'
  post 'namespace/new' => 'namespaces#store_new_namespace'
end
