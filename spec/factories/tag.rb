FactoryGirl.define do
  factory :tag, class: Pulitzer::Tag do
    sequence(:name) { |n| "The north #{n}" }
  end
end
