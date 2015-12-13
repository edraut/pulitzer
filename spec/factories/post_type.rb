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
  end
end
