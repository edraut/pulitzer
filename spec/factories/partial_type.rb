FactoryGirl.define do
  factory :partial_type, class: Pulitzer::PartialType do
    sequence(:label) { |n| "Winterfell news #{n}" }
    sequence(:sort_order)
    association :free_form_section_type
    association :post_type
    association :layout
  end
end
