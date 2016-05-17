FactoryGirl.define do
  factory :tag, class: Pulitzer::Tag do
    sequence(:name) { |n| "The north #{n}" }

    trait :root do
      hierarchical true
    end

    trait :flat do
      hierarchical false
    end
  end
end
