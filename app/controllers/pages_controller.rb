class PagesController < ApplicationController

  include UsersHelper

  def index
    @user = current_user
    redirect_to @user if @user
  end

end
