class Experiment < ActiveRecord::Base
  belongs_to :owner, class_name: "User"
  belongs_to :lab
  has_many :logs
  has_many :assignments
  has_many :staffs, through: :assignments
  validates_presence_of :status, :title, :hypothesis, :description, :owner_id, :lab_id
  validates :status, in: { inclusion: ["proposed", "in progress", "complete"] }
end
