module Pulitzer
  module MainHelper
    # Will this clash with helper methods like devise, cancan?
    def authorized?
      Pulitzer.skip_metadata_auth? || self.instance_eval(&Pulitzer.metadata_closure)
    end
  end
end
