Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'dashboard#index'
  get 'signup' => 'login#signup'
  post 'signup/new' => 'login#create_new_user'

  get 'login' => 'login#login_user'
  post 'login/verifyuser' => 'login#verify_login_user'
  get 'logout' => 'login#logout'

  get 'dashboard/user' => 'dashboard#index'

  get 'organization' => 'organization#index'
  get 'organization/create' => 'organization#create'
  post 'organization/create' => 'organization#store'
  patch ':organization/member' => 'organization_member#update_role'
  delete ':organization/member' => 'organization_member#delete_member'
  get ':organization/:namesearch/search' => 'organization_member#index'

  get ':organization/services' => 'services#index'
  get ':organization/services/new' => 'services#create'
  post ':organization/services/new' => 'services#store'

  get ':organization/:service/namespaces' => 'namespace#index'
  get ':organization/:service/namespaces/new' => 'namespace#create'
  post ':organization/:service/namespaces/new' => 'namespace#store'


  get ':organization/:service/:namespace/:version' => 'configurations#show'
  get ':organization/:service/:namespace/:version/edit' => 'configurations#configuration_update'

  post ':organization/:service/:namespace/:version/edit/update' => 'configurations#store_configuration_update'
 
end
