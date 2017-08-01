module Pulitzer
  class ClonePostJob < ActiveJob::Base
    queue_as Pulitzer.clone_queue

    def perform(post)
      Pulitzer::Pulitzer::PostsController::Clone.new(post).call
    end

  end
end
