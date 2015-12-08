require 'spec_helper'

describe Pulitzer do
  let(:pulitzer) { Class.new { include Pulitzer } }

  it 'has a version number' do
    expect(Pulitzer::VERSION).not_to be nil
  end
end
