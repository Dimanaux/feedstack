Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  root to: "pages#home"

  resources :feedbacks, only: %I( new create )
  get '/feedbacks/success', to: 'feedbacks#success', as: :feedbacks_success
  get '/admin/feedbacks', to: 'feedbacks#index', as: :admin_feedbacks
end
