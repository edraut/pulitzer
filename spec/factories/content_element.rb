FactoryGirl.define do
  factory :content_element, class: Pulitzer::ContentElement do
    sequence(:label)  { |n| "Slide 1 content element #{n}" }
    title             { "Night's Watch" }
    body              { "I pledge my life and honor to the Night's Watch, for this night and all the nights to come" }
    association :content_element_type

    trait :video do
      body { "https://www.youtube.com/watch?v=yLisM2KPDIA" }
      association :content_element_type, :video
    end

    trait :image do
      image { Rack::Test::UploadedFile.new(File.join(Dir.pwd, "spec/support/files/sam_and_snow.jpg")) }
      association :content_element_type, :image
    end
  end
end
