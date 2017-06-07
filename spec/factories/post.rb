FactoryGirl.define do
  factory :post, class: Pulitzer::Post do
    sequence(:title) { |n| "Winterfell news #{n}" }
    association :post_type_version
  end
end
