class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  private
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end

  def access_tmdb
    Tmdb::Api.key(ENV['MOVIEDB_API_KEY'])
    Tmdb::Api.language("ja")
  end

end
