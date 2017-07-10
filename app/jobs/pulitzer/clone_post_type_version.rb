module Pulitzer
  class ClonePostTypeVersion < ActiveJob::Base
    queue_as Pulitzer.clone_queue

    def perform(post_type_version_params)
      Pulitzer::PostTypeVersionsController::Clone.new(post_type_version_params).call
    end

  end
end
