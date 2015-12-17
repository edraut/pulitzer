FactoryGirl.define do
  factory :post_type_content_element_type, class: Pulitzer::PostTypeContentElementType do
    sequence(:label)      { |n| "Slide 1 content element #{n}" }
    association :post_type
    association :content_element_type
  end
end
