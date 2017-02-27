module Pulitzer
  class VersionAccessError < RuntimeError; end
  class VersionProcessingError < VersionAccessError; end
  class VersionMissingError < VersionAccessError; end
end