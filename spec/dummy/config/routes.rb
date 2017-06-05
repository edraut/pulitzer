Rails.application.routes.draw do
  get 'welcome/:slug' => 'pages#welcome', as: 'welcome'
  mount Pulitzer::Engine => "/pulitzer"
  root to: 'pages#news_posts'
  get '/about-us', to: 'pages#about_us'
  get '/news-posts', to: 'pages#news_posts'

  namespace :pulitzer_preview do
		get 'welcome/:slug' => 'pages#welcome', as: 'welcome'
    get '/about-us', to: 'pages#about_us', as: 'about_us'
  end
end
