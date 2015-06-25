Pulitzer::Engine.routes.draw do
  resources :posts
  resources :content_elements
  resources :post_types
  resources :content_element_types
  resources :post_type_content_element_types
  resources :post_tags
  resources :tags
  root to: 'post_types#index'
end
