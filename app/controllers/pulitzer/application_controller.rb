class Pulitzer::ApplicationController < Pulitzer.base_controller
  helper Pulitzer::Engine.helpers
  layout Pulitzer.layout

private
  def authenticate_user!
    unless Pulitzer.skip_authentication? || instance_eval(&Pulitzer.authentication_closure)
      redirect_to main_app.root_url
    end
  end
end
