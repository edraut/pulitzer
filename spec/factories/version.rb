FactoryGirl.define do
  factory :version, class: Pulitzer::Version do
    status { Pulitzer::Version.statuses[:preview] }
    association :post
  end
end
