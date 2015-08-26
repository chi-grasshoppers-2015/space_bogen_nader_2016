class Experiment < ActiveRecord::Base
  belongs_to :owner, class_name: "User"
  belongs_to :lab
  has_many :procedures
  has_many :logs, through: :procedures
  has_many :staffs_experiments
  has_many :staffs, through: :staffs_experiments
  validates_presence_of :title, :hypothesis, :description, :owner_id, :lab_id, :start_date, :end_date, :allotted_time
  validate :status_must_be_valid
  validate :conclusion_must_be_present_if_status_is_complete

  def self.valid_statuses
    ["proposed", "active", "complete"]
  end

  def status_must_be_valid
    if self.status && !Experiment.valid_statuses.include?(self.status)
      errors.add(:status, "must be one of the following: " + Experiment.valid_statuses.join(" , "))
    end
  end

  def conclusion_must_be_present_if_status_is_complete
    if self.status == "complete" && self.conclusion.blank?
      errors.add(:conclusion, "can't be blank if status is complete")
    end
  end

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

  def completed?
    self.status == "complete"
  end

  def staffed?
    self.staffs.length > 0
  end



end
