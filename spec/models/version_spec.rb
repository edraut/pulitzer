require 'rails_helper'

describe Pulitzer::Version do
  let(:version) { build :version }

  it 'has a valid factory' do
    expect(version).to be_valid
  end

  describe "Active Model validations" do
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:post_id) }
  end

  describe "ActiveRecord associations" do
    it { should have_many(:content_elements).dependent(:destroy) }
    it { should have_many(:post_tags).dependent(:destroy) }
    it { should belong_to(:post) }
  end

  describe 'ActiveRecord enums' do
    it { should define_enum_for(:status).
      with([:preview, :active, :archived, :abandoned, :processing, :processing_failed]) }
  end

  describe 'post tag filters' do
    it "has post tag filter methods" do
      label = create :tag
      version.save
      version.post_tags.create label: label
      expect(version.has_label_type(label.class.name)).to be true
      expect(version.has_label(label)).to be true
      expect(version.post_tags_for(label.class.name).map(&:label)).to include label
    end
  end

  describe '#required_partials?' do
    let!(:partial_type)           { create(:partial_type) }
    let(:post_type)               { free_form_section_type.post_type }
    let!(:post)                   { create(:post, post_type: post_type) }
    let(:preview_version)         { post.preview_version }
    let(:free_form_section_type)  { partial_type.free_form_section_type }


    it 'Without any required partials' do
      expect(version.required_partials?).to eq true
    end

    it 'With required partials' do
      Pulitzer::CreatePostTypeFreeFormSections.new(free_form_section_type).call
      Pulitzer::CreateFreeFormSectionPartials.new(partial_type).call
      expect(preview_version.required_partials?).to eq true
    end

    it 'With a missing partial' do
      Pulitzer::CreatePostTypeFreeFormSections.new(free_form_section_type).call
      Pulitzer::CreateFreeFormSectionPartials.new(partial_type).call
      partial = preview_version.free_form_sections.first.partials.first
      partial.destroy
      expect(preview_version.required_partials?).to eq false
    end
  end
end
