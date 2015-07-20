Rails.application.routes.draw do
  mount Pulitzer::Engine => "/pulitzer"
  root to: 'pages#news_posts'
  get '/about-us', to: 'pages#about_us'
  get '/news-posts', to: 'pages#news_posts'
end
