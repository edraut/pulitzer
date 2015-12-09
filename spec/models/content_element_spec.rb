require 'rails_helper'

describe Pulitzer::ContentElement do
  let(:content_element) { build :content_element }

  it 'has a valid factory' do
    expect(build(:content_element)).to be_valid
  end

  describe "Active Model validations" do
    it { should validate_presence_of(:label) }
    it { should validate_uniqueness_of(:label).scoped_to(:version_id) }
  end

  describe "ActiveRecord associations" do
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
      expect(content_element.html).to match "I pledge my life"
    end
  end

  describe '.video_link' do
    it 'not a video' do
      expect(content_element.video_link).to eq nil
    end

    context 'video type' do
      let(:content_element) { build :content_element, :video }

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
      content_element = build :content_element, :image
      expect(content_element.empty_body?).to be false
    end
  end
end
