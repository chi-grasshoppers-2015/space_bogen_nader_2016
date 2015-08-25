class LogsController < ResourcesController
	before_action :set_log_context
	# def index
	# end

	def new
		@log = Log.new
	end

	def create
		params[:log].merge!({ time_performed: time_performed_formatted })
		@log = @procedure.logs.create!(log_params)
		if @log.valid?
			redirect_to @experiment
		else
			redirect_to @experiment
		end
	end

	def edit
		@log = find_log
	end

	def update
		@log = find_log
		@log.update(log_params)
		redirect_to @experiment
	end

	def destroy
		@log = find_log
		@log.destroy
		redirect_to @experiment
	end

	private

		def find_log
			Log.find(params[:id])
		end

		def log_params
			params.require(:log).permit(:observation, :staff_id, :procedure_id, :time_spent, :time_performed)
		end

		def set_log_context
			@experiment = Experiment.find(params[:experiment_id])
			@procedure = Procedure.find(params[:procedure_id])
		end

		def time_performed_formatted
			DateTime.new(params[:log]["time_performed(1i)"].to_i,
						 			 params[:log]["time_performed(2i)"].to_i,
						 			 params[:log]["time_performed(3i)"].to_i,
						 			 params[:log]["time_performed(4i)"].to_i,
						 			 params[:log]["time_performed(5i)"].to_i)
		end


end
