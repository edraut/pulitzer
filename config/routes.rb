Pulitzer::Engine.routes.draw do
  resources :posts do
    member do
      get :processing_preview
    end
  end
  resources :content_elements
  resources :post_tags

  resources :content_elements
  resources :partials do
    collection do
      patch :update_all
    end
  end
  resources :tags
  resources :post_types
  resources :versions
  resources :content_element_types
  resources :post_type_content_element_types
  resources :free_form_section_types
  resources :layouts
  resources :free_form_sections
  root to: 'post_types#index'
end
