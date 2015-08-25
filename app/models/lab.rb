class Lab < ActiveRecord::Base

  validates_presence_of :location, :name, :allotted_time

  has_many :experiments

  def remaining_time
    if self.experiments.where(status: "active").any?
      experiments = self.experiments.where(status: "active")
      times = experiments.pluck(:allotted_time)
      used_time = times.reduce(:+)
      self.allotted_time - used_time
    else
      self.allotted_time
    end
  end

end
