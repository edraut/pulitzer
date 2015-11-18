Pulitzer::Engine.routes.draw do
  resources :posts do
    resources :content_elements
    resources :post_tags
  end
  resources :content_elements do
    collection do
      patch :update_all
    end
  end
  resources :post_types
  resources :versions
  resources :content_element_types
  resources :post_type_content_element_types
  root to: 'post_types#index'
end
