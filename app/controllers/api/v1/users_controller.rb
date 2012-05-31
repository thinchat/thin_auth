class Api::V1::UsersController < ApplicationController

  def show
    @user = User.where(id: params[:id].to_s).first
    if @user
      render :json => @user.to_json
    else
      render :json => {:error => "user not found"}.to_json, :status => 404
    end
  end

end
