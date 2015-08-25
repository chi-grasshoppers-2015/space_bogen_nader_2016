class LogsController < ActionController::Base
	# def index
	# end

	def new
		@log = Log.new
	end

	def create
		@log = Log.create(log_params)
		if @log.valid?
			redirect_to @log
		else
			render :new
		end
	end

	def show
		@log = find_log
	end

	def update
		@log = find_log
		@log.update(log_params)
		redirect_to @log
	end

	def delete
		Log.destroy(param[:id])
		redirect_to logs_path
	end

	private

		def find_log
			Log.find(params[:id])
		end

		def log_params
			params.require(:log).permit(:observation, :logger_id, :procedure_id)
		end




end