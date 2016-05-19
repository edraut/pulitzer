FactoryGirl.define do
  factory :version, class: Pulitzer::Version do
    status { Pulitzer::Version.statuses[:preview] }
    association :post

    trait :with_content_elements do
      after(:create) do |version|
        create_list(:content_element, 3, version_id: version.id)
      end
    end

    trait :with_free_form_sections do
      after(:create) do |version|
        version.free_form_sections.create(name: 'section A')
        version.free_form_sections.create(name: 'section B')
        version.free_form_sections.create(name: 'section C')
      end
    end
  end
end
