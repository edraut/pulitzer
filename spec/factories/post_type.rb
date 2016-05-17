FactoryGirl.define do
  factory :post_type, class: Pulitzer::PostType do
    sequence(:name) { "Winterfell news #{1}" }
    plural          { false }
    kind            { Pulitzer::PostType.kinds[:template]}

    trait :with_content_elements do
      after(:create) do |post_type|
        create_list(:post_type_content_element_type, 3, post_type_id: post_type.id)
      end
    end

    trait :with_free_form_sections do
      after(:create) do |post_type|
        post_type.free_form_section_types.create(name: 'Main Body')
        post_type.free_form_section_types.create(name: 'Side Bar')
        post_type.free_form_section_types.create(name: 'Footer List')
      end
    end
  end
end
