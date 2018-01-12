Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :pass

  post 'login', to: 'auth#login'

  post 'register', to: 'auth#register'

end
