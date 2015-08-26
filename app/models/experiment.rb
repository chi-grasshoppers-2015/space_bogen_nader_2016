class Experiment < ActiveRecord::Base
  belongs_to :owner, class_name: "User"
  belongs_to :lab
  has_many :procedures
  has_many :logs, through: :procedures
  has_many :staffs_experiments
  has_many :staffs, through: :staffs_experiments
  validates_presence_of :title, :hypothesis, :description, :owner_id, :lab_id, :start_date, :end_date, :allotted_time
  validates :status, inclusion: { in: Experiment.valid_statuses }

  def hours_left
    self.allotted_time - self.hours_spent
  end

  def hours_spent
    self.logs.map(&:time_spent).reduce(:+) || 0
  end

  def assigned_staff
    self.staffs_experiments.select{|s| s.assigned}.map(&:staff)
  end

  def starred_staff
    self.staffs_experiments.select{|s| s.starred}.map(&:staff)
  end

  def proposal?
    Date.today < self.start_date || !self.staffed?
  end

  def in_progress?
    !self.completed? && !self.proposal?
  end

  def completed?
    Date.today > self.end_date
  end

  def staffed?
    self.staffs.length > 0
  end

  def self.valid_statuses
    ["proposed", "active", "complete"]
  end

end
