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
      with([:preview, :active, :archived, :abandoned]) }
  end
end
