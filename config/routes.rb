Pulitzer::Engine.routes.draw do
  resources :posts do
    get 'edit_multiple', to: 'content_elements#edit_multiple',
      as: 'content_elements_edit_multiple'
    put 'update_multiple', to: 'content_elements#update_multiple',
      as: 'content_elements_update_multiple'
  end
  resources :content_elements
  resources :post_types
  resources :content_element_types
  resources :post_type_content_element_types
  resources :post_tags
  resources :tags
  root to: 'post_types#index'
end
