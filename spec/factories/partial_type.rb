FactoryGirl.define do
  factory :partial_type, class: Pulitzer::PartialType do
    sequence(:label) { |n| "King's Landing news #{n}" }
    sequence(:sort_order)
    association :free_form_section_type
    association :post_type_version
  end
end
