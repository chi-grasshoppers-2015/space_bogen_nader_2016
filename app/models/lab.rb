class Lab < ActiveRecord::Base

  validates_presence_of :location, :name

  has_many :experiments


end
