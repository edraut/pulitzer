module Pulitzer
  class ReprocessContentImageJob < ActiveJob::Base
    queue_as Pulitzer.image_queue

    def perform(content_element)
      content_element.reprocess_versions!
    end
  end
end