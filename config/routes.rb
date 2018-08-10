Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'logins#login_user'
  get 'signup' => 'logins#signup'

  post 'signup/new' => 'logins#create_new_user'

  get 'login' => 'logins#login_user'
  post 'login/verifyuser' => 'logins#verify_login_user'
  get 'logout' => 'dashboards#logout'

  get 'dashboard/user' => 'dashboards#index'

  get ':organization/services' => 'services#service_list'
  get ':organization/services/new' => 'services#new_service'
  post ':organization/services/new' => 'services#store_new_service'

  get 'namespace/edit/:servicename/:namespace/:version' => 'configurations#configuration_update'
  get 'namespace/:servicename/new' => 'namespaces#new_namespace'
  get 'namespace/:servicename/:namespace/:version' => 'configurations#configuration_list'
  get 'namespace/:servicename' => 'namespaces#namespace_list'
  post 'namespace/new' => 'namespaces#store_new_namespace'
  post 'namespace/update' => 'configurations#store_configuration_update'
  get 'organization' => 'organization#index'
  get 'organization/create' => 'organization#create'
  post 'organization/create' => 'organization#store'
end
