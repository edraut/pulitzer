FactoryGirl.define do
  factory :content_element, class: Pulitzer::ContentElement do
    label       { "Slide 1 content element" }
    title       { "Night's Watch" }
    content_element_type { Pulitzer::ContentElementType.find_by(name: 'Text') }
    body        { "I pledge my life and honor to the Night's Watch, for this night and all the nights to come" }

    trait :video do
      content_element_type { Pulitzer::ContentElementType.find_by(name: 'Video') }
      body { "https://www.youtube.com/watch?v=yLisM2KPDIA" }
    end

    trait :image do
      content_element_type { Pulitzer::ContentElementType.find_by(name: 'Image') }
      image { Rack::Test::UploadedFile.new(File.join(Dir.pwd, "spec/support/files/sam_and_snow.jpg")) }
    end
  end
end
