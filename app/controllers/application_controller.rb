class ApplicationController < ActionController::Base
  # before_action :redirect_not_login

  private

  def redirect_not_login
    return redirect_to :login unless session[:login]
  end
end
