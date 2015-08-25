class ResourcesController < ApplicationController
  before_action :authenticate

  include SessionsHelper

  def authenticate
    if !logged_in?
      redirect_to :root, flash: { error: "You must be logged in to access that." }
    end
  end
end
