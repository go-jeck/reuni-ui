Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'logins#login_user'

  post 'login/verifyuser' => 'logins#verify_login_user'
  get 'logout' => 'dashboards#logout'

  get 'dashboard/user' => 'dashboards#user_dashboard'

  get 'service' => 'services#service_list'
  get 'service/new' => 'services#new_service'
  post 'service/new' => 'services#store_new_service'

  get 'namespace/:servicename/new' => 'namespaces#new_namespace'
  get 'namespace/:servicename/:namespace/:version' => 'configurations#configuration_list'
  get 'namespace/:servicename' => 'namespaces#namespace_list'
  post 'namespace/new' => 'namespaces#store_new_namespace'

end
