FactoryGirl.define do
  factory :post_type_version, class: Pulitzer::PostTypeVersion do
    association :post_type
    
    trait :with_content_elements do
      after(:create) do |post_type_version|
        create_list(:post_type_content_element_type, 3, post_type_version_id: post_type_version.id)
      end
    end

    trait :with_free_form_sections do
      after(:create) do |post_type_version|
        post_type_version.free_form_section_types.create(name: 'Main Body')
        post_type_version.free_form_section_types.create(name: 'Side Bar')
        post_type_version.free_form_section_types.create(name: 'Footer List')
      end
    end
  end
end
