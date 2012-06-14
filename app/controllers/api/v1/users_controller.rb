class Api::V1::UsersController < ApplicationController
  respond_to :json

  def index
    if params[:authentication_token].present? && @user = User.where(authentication_token: params[:authentication_token].to_s).first
      @user
    else
      render :json => {:error => "User not found."}, :status => :not_found
    end
  end
end