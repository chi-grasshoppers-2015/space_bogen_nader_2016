class StaffsExperiment < ActiveRecord::Base

  validates_presence_of :experiment_id, :staff_id

  belongs_to :experiment
  belongs_to :staff, class_name: "User"
  after_initialize :set_defaults

  def set_defaults
    self.starred ||= false
    self.assigned ||= false
  end

end
