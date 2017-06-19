module Pulitzer
  module ControllerHelpers
    def pulitzer_view_path(version_number)
      File.join Pulitzer.public_controller,
        action_name,
        "v_#{version_number.to_s}.html.erb"
    end
  end
end