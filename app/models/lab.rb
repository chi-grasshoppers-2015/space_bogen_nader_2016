class Lab < ActiveRecord::Base

  validates_presence_of :location, :name, :allotted_time

  has_many :experiments


end
