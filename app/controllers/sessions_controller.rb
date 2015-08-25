class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(params[:user])
    if User.authenticate(@user.email, @user.password)
      session[:user_id] = @user.id
      redirect_to @user
    else
      render "new"
    end
  end

  def delete
    session.clear
    redirect_to :root
  end

end
