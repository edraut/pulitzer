module Pulitzer
  module ApplicationHelper
    def authenticated
      Pulitzer.skip_metadata_auth? || self.instance_eval(&Pulitzer.metadata_closure)
    end
  end
end
