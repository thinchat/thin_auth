class PagesController < ApplicationController

  def index
    @session = cookies.signed[:user]
  end

end
