class ApplicationController < ActionController::Base
  before_filter :setup_user

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def setup_user
    @current_user = User.new
    if params[:admin]
      @current_user.admin = true
    end
  end

  def self.foo
    'bar'
  end

  def current_user
    @current_user
  end
end
