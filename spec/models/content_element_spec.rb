require 'rails_helper'

describe Pulitzer::ContentElement do
  let(:content_element) { Pulitzer::ContentElement.first }
  let(:body) {content_element.body}
  let(:image_cet) {Pulitzer::ContentElementType.find_by name: 'Image'}
  let(:video_cet) {Pulitzer::ContentElementType.find_by name: 'Video'}

  it 'has a valid factory' do
    expect(content_element).to be_valid
  end

  describe 'ActiveRecord associations' do
    it { should belong_to(:version) }
    it { should belong_to(:content_element_type) }
    it { should belong_to(:post_type_content_element_type) }
  end

  describe 'ActiveRecord enums' do
    it { should define_enum_for(:kind).with([:template, :free_form]) }
  end

  describe '.html' do
    it 'empty body' do
      content_element.body = nil
      expect(content_element.html).to eq ""
    end

    it 'with body content' do
      expect(content_element.html).to match body
    end
  end

  describe '.video_link' do
    it 'not a video' do
      expect(content_element.video_link).to eq nil
    end

    context 'video type' do
      let(:content_element) { ce = Pulitzer::ContentElement.first
        ce.update body: "https://www.youtube.com/watch?v=yLisM2KPDIA", content_element_type: video_cet
        ce
      }

      it 'youtube' do
        expect(content_element.video_link).to match "https://www.youtube.com/embed/yLisM2KPDIA"
      end

      it 'vimeo' do
        content_element.body = "https://vimeo.com/124246059"
        expect(content_element.video_link).to match "https://player.vimeo.com/video/124246059"
      end
    end
  end

  describe '.empty_body?' do
    it 'with body' do
      expect(content_element.empty_body?).to be false
    end

    it 'without content' do
      content_element.body = nil
      expect(content_element.empty_body?).to be true
    end

    it 'with an image' do
      content_element.update image: Rack::Test::UploadedFile.new(File.join(Dir.pwd, "spec/support/files/sam_and_snow.jpg")), content_element_type_id: image_cet.id
      expect(content_element.empty_body?).to be false
    end
  end
end
