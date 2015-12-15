FactoryGirl.define do
  factory :version, class: Pulitzer::Version do
    status { Pulitzer::Version.statuses[:preview] }
    association :post

    trait :with_content_elements do
      after(:create) do |version|
        create_list(:content_element, 3, version_id: version.id)
      end
    end
  end
end
