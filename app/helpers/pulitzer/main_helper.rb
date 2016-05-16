module Pulitzer
  module MainHelper
    def authenticated
      binding.pry
      Pulitzer.skip_metadata_auth? || self.instance_eval(&Pulitzer.metadata_closure)
    end
  end
end
