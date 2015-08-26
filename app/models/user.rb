class User < ActiveRecord::Base

  validates_presence_of :name, :email, :hashed_password, :position
  validates :email, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)(@dbc.edu)\Z/i
  validates_inclusion_of :position, in: %w( staff faculty )

  after_initialize :set_defaults

  has_many :experiments, foreign_key: :owner_id
  has_many :logs

  has_many :staffs_experiments

  def set_defaults
    self.position ||= "staff"
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

  def self.not_assigned_to_experiment(experiment)
    assigned_se = StaffsExperiment.where(assigned: true, experiment_id: experiment.id)
    starred_se = StaffsExperiment.where(starred: true, experiment_id: experiment.id)
    assigned_staff = assigned_se.map{|s| self.find(s.staff_id)}
    starred_staff = starred_se.map{|s| self.find(s.staff_id)}
    self.where(position: "staff") - assigned_staff - starred_staff
  end

  def staff_experiments
    staff_assignments = StaffsExperiment.where(staff_id: self.id, assigned: true)
    staff_assignments.map {|se| Experiment.find(se.experiment_id)}
  end

end
