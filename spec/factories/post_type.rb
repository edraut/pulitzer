FactoryGirl.define do
  factory :post_type, class: Pulitzer::PostType do
    sequence(:name) { "Winterfell news #{1}" }
    plural          { false }
    kind            { Pulitzer::PostType.kinds[:template]}

    after(:create) do |post_type|
      post_type.post_type_versions.create status: 'published'
    end
  end
end
