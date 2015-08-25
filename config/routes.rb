Pulitzer::Engine.routes.draw do
  resources :posts do
    resources :content_elements
  end
  resources :content_elements
  resources :post_types
  resources :content_element_types
  resources :post_type_content_element_types
  resources :post_tags
  resources :tags
  root to: 'post_types#index'
end
