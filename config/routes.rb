Rails.application.routes.draw do
  resources :articles
  resources :users

  root to: 'welcome#home'
  get 'about', to: 'welcome#about'
end
