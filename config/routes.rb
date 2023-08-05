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
end

end
