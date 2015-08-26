module UsersHelper

  def current_user
    User.find(session[:user_id])
  end

  def is_faculty?
    current_user.position == "faculty"
  end

end
