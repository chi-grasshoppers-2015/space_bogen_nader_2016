class LogsController < ActionController::Base
	# def index
	# end

	def new
		@log = Log.new
	end

	def create
		@log = Log.create(log_params)
		if @log.valid?
			redirect_to @log.procedure.experiment
		else

		end
	end

	def edit
		@log = find_log
		@procedure = @log.procedure
	end

	def update
		@log = find_log
		@log.update(log_params)
		redirect_to @log.procedure.experiment
	end

	def destroy
		@log = find_log
		@experiment = @log.procedure.experiment
		@log.destroy
		redirect_to @experiment
	end

	private

		def find_log
			Log.find(params[:id])
		end

		def log_params
			params.require(:log).permit(:observation, :staff_id, :procedure_id)
		end




end
