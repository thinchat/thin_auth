class PagesController < ApplicationController

  def index
    @session = cookies[:user]
  end

end
