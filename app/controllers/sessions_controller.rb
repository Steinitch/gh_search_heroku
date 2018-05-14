class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create

  def index; end

  def create
    user = User.find_or_create_by(provider: auth_hash[:provider], uid: auth_hash[:uid]) do |u|
      u.name = auth_hash[:info][:name]
      u.email = auth_hash[:info][:email]
    end
    session[:user_id] = user.id
    redirect_to searches_path

  end

  def destroy
    reset_session
    redirect_to :root
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
