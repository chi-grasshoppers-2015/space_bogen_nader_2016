class User < ActiveRecord::Base

  validates_presence_of :name, :email, :hashed_password, :position
  validates :email, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)(@gmail.com)\Z/i
  validate :type_of_user

  after_initialize :set_defaults

  has_many :experiments
  has_many :logs

  def set_defaults
    self.position ||= "staff"
  end

  def type_of_user
    if self.position != "staff" && self.position != "faculty"
      errors.add(:user_type, "must be staff or faculty")
    end
  end

  def password
    @password ||= BCrypt::Password.new(hashed_password)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.hashed_password = @password
  end

  def self.authenticate(email, password)
    @user = User.find_by_email(email)
    @user if @user && @user.password == password
  end

  def faculty?
    self.position == "faculty"
  end

end
