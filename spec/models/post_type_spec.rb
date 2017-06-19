require 'rails_helper'

describe Pulitzer::PostType do
  let(:post_type) { build :post_type }

  it 'has a valid factory' do
    expect(post_type).to be_valid
  end

  describe "Active Model validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:kind) }
  end

  describe 'ActiveRecord enums' do
    it { should define_enum_for(:kind).
      with([:template, :partial]) }
  end
end
