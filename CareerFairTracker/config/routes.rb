Rails.application.routes.draw do

  get 'admin/dashboard', to: 'admins#dashboard', as: 'admin_dashboard'

  get 'student/dashboard', to: 'students#dashboard', as: 'student_dashboard'

  get 'recruiter/dashboard', to: 'recruiters#dashboard', as: 'recruiter_dashboard'
  get 'recruiter/select_event', to: 'recruiters#select_event', as: 'recruiter_selects_event'
  get 'recruiter/generate_booth_code', to: 'recruiters#generate_booth_code', as: 'generate_booth_code'
  
  resources :admins
  delete 'events', to: 'events#destroy'
  resources :events
  resources :recruiters
  root 'home#index'
  post 'users', to: 'users#create', as: 'user'
 
  post 'signup', to: 'users#create', as: 'signup'
  get 'signup', to: 'users#new'
  
  get 'dashboard', to: 'dashboards#index', as: 'dashboard'

  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  match '/logins' => 'logins#index', via: :get
  match '/logins' => 'logins#index', via: :post
  
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :home
  resources :students
  resources :dashboards
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
