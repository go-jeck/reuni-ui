Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'dashboard#index'
  get 'signup' => 'login#signup'

  post 'signup/new' => 'login#create_new_user'

  get 'login' => 'login#login_user'
  post 'login/verifyuser' => 'login#verify_login_user'
  get 'logout' => 'login#logout'

  get 'dashboard/user' => 'dashboard#index'

  get ':organization/services' => 'services#index'
  get ':organization/services/new' => 'services#create'
  post ':organization/services/new' => 'services#store'

  get ':organization/:service/namespaces' => 'namespace#index'
  get ':organization/:service/namespaces/new' => 'namespace#create'
  post ':organization/:service/namespaces/new' => 'namespace#store'
  get 'namespace/edit/:servicename/:namespace/:version' => 'configurations#configuration_update'

  get 'namespace/:servicename/:namespace/:version' => 'configurations#configuration_list'
  get 'namespace/:servicename' => 'namespace#namespace_list'
  post 'namespace/new' => 'namespace#store_new_namespace'
  post 'namespace/update' => 'configurations#store_configuration_update'
  get 'organization' => 'organization#index'
  get 'organization/create' => 'organization#create'
  post 'organization/create' => 'organization#store'
end
