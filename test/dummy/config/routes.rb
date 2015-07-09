Rails.application.routes.draw do
  mount Pulitzer::Engine => "/pulitzer"
  get '/about-us', to: 'pages#about_us'
end
