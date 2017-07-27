FactoryGirl.define do
  factory :post, class: Pulitzer::Post do
    sequence(:title) { |n| "Winterfell news #{n}" }
    association :post_type_version
    after(:create) do |post_type|
      post_type.create_preview_version
    end
  end
end
