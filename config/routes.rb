Pulitzer::Engine.routes.draw do
  resources :posts do
    member do
      get :processing_preview
      get :edit_slug
      get :edit_title
      get :show_slug
      patch :update_slug
    end
  end
  resources :content_elements
  resources :post_tags

  resources :content_elements
  resources :partials do
    collection do
      patch :update_all
    end
    member do
      patch :upgrade
    end
  end

  resources :tags
  resources :post_types
  resources :post_type_versions do
    collection do
      post :clone
    end
    member do
      get :template
      patch :change_state
    end
  end

  resources :custom_option_lists
  resources :custom_options

  resources :versions
  resources :content_element_types
  resources :post_type_content_element_types
  resources :styles
  resources :free_form_section_types
  resources :partial_types do
    collection do
      patch :update_all
    end
  end
  resources :background_styles
  resources :justification_styles
  resources :sequence_flow_styles
  resources :arrangement_styles

  resources :free_form_sections
  root to: 'post_types#index'
end
