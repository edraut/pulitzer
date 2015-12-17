FactoryGirl.define do
  factory :post_tag, class: Pulitzer::PostTag do
    association :label, factory: :tag
    association :version
  end
end
