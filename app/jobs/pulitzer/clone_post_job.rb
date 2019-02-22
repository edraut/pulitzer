module Pulitzer
  class ClonePostJob < ActiveJob::Base
    queue_as Pulitzer.clone_queue

    def perform(post, new_post)
      Pulitzer::PostsController::Clone.new(post, new_post).call
    end

  end
end
