module Pulitzer
  class CloneVersionJob < ActiveJob::Base
    queue_as Pulitzer.clone_queue

    def perform(version)
      Pulitzer::CloneVersion.new(version).call
    end

  end
end