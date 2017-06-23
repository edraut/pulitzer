module Pulitzer
  class CloneVersionJob < ActiveJob::Base
    queue_as Pulitzer.clone_queue

    def perform(version, new_version = nil)
      Pulitzer::CloneVersion.new(version, new_version).call
    end

  end
end
