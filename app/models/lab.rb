class Lab < ActiveRecord::Base

  validates_presence_of :location, :name, :alotted_time

  has_many :experiments


end
