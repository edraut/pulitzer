FactoryGirl.define do
  factory :free_form_section_type, class: Pulitzer::FreeFormSectionType do
    sequence(:name) { |n| "Winterfell news #{n}" }
    sequence(:sort_order)
    association :post_type
  end
end
