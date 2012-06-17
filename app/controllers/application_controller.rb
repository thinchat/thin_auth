class ApplicationController < ActionController::Base
  private

  def after_sign_out_path_for(resource_or_scope)
    cookies.delete :user
    current_root_url
  end

  def after_sign_in_path_for(resource_or_scope)
    "#{current_root_url}/rooms"
  end

  private

  def current_root_url
    if Rails.env.production?
      "http://thinchat.com"
    elsif Rails.env.development?
      "http://localhost:3000"
    else
      "http://staging.thinchat.com"
    end
  end
end
