FactoryGirl.define do
  factory :post_type_content_element_type, class: Pulitzer::PostTypeContentElementType do
    label { "Slide 1 content element" }
    association :post_type
    content_element_type { Pulitzer::ContentElementType.find_by(name: 'Text') }
  end
end
