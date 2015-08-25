class LogsController < ActionController::Base
	# Logs per Experiment, contained in experiment controller?
	# def index
	# end

	def new
		@log = Log.new
	end

	def create
		@log = Log.create(log_params)
	end

	def show
	end

	def update
	end

	def delete
	end

	private

		def log_params
			
		end




end