class Procedure < ActiveRecord::Base
  has_many :logs
  belongs_to :experiment
  validates_presence_of :experiment_id, :instructions
end
