FactoryGirl.define do
  factory :content_element_type, class: Pulitzer::ContentElementType do
    sequence(:name) { |n| "Text #{n}" }

    trait :text do
      name { "Text" }
    end

    trait :video do
      name { "Video" }
    end

    trait :image do
      name { "Image" }
    end
  end
end
