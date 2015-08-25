class Log < ActiveRecord::Base
	belongs_to :logger, class_name: "User"
	belongs_to :procedure
	validates_presence_of :observation, :procedure_id, :logger_id

	def procedure_instructions
		self.procedure.instructions
	end

	def experiment_title
		self.procedure.experiment.title
	end
end
