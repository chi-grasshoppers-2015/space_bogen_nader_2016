class Experiment < ActiveRecord::Base
  belongs_to :owner, class_name: "User"
  belongs_to :lab
  has_many :procedures
  has_many :staffs_experiments
  has_many :staffs, through: :staffs_experiments
  validates_presence_of :title, :hypothesis, :description, :owner_id, :lab_id, :start_date, :end_date, :alotted_time

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

end
