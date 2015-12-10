FactoryGirl.define do
  factory :post_type, class: Pulitzer::PostType do
    name    { "Winterfell news" }
    plural  { false }
    kind    { Pulitzer::PostType.kinds[:template]}
  end
end
