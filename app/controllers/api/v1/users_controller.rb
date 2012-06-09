class Api::V1::UsersController < ApplicationController
  respond_to :json

  def show
    if @user = User.where(id: params[:id].to_s).first
      respond_with @user
    else
      render :json => {:error => "User not found."}, :status => :not_found
    end
  end
end