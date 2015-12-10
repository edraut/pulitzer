FactoryGirl.define do
  factory :version, class: Pulitzer::Version do
    status { Pulitzer::Version.statuses[:preview] }
    post_id 1
  end
end
