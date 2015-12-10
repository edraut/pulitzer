FactoryGirl.define do
  factory :post, class: Pulitzer::Post do
    title { "Winterfell news" }
    association :post_type
  end
end
