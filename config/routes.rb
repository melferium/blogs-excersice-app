class SubdomainConstraints
  def self.matches?(request)
    subdomain = %w{www admin}
    (request.subdomain.present? && !subdomain.include?(request.subdomain))
  end
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  constraints SubdomainConstraints do 
    resources :articles
    
  end
  
  
  root 'pages#home'
  get 'about', to: 'pages#about'
  get 'signup', to: 'users#new'
  resources :users, except: [:new]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  
end
