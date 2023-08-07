Rails.application.routes.draw do

devise_for :customers, controllers: {
  passwords: "public/paswords",
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

scope module: :public do
  root to: 'homes#top'
  get '/about' => 'homes#about'
  get '/mypage' => 'customers#show', as: 'mypage'
  get '/customers/info/edit' => 'customers#edit'
  patch '/customers/info' => 'customers#update'
  patch '/customers/information' => 'customers#update'
  get '/customers/unsubscribe' => 'customers#unsubscribe'
  patch '/customers/withdrawal' => 'customers#withdrawal'
  delete '/cart_items/destroy_all' => 'cart_items#destroy_all'
  post '/orders/confirm' => 'orders#confirm'
  get '/orders/thanks' => 'orders#thanks'
end

namespace :admin do
  root to: 'homes#top'
  resources :items, only: [:new, :index, :create, :show, :edit, :update]
  resources :genres, only: [:index, :create, :edit, :update]
  resources :customers, only: [:index, :show, :edit, :update]
  resources :orders, only: [:show]
end

end
