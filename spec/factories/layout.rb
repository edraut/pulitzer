FactoryGirl.define do
  factory :layout, class: Pulitzer::Layout do
    sequence(:name) { |n| "Photo bg text large #{n}" }
    association :post_type
  end
end
