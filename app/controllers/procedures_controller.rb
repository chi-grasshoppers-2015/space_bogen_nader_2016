class ProceduresController < ResourcesController
  before_action :find_experiment

  def show
    @procedure = find_procedure
  end

  def new
    @procedure = Procedure.new
  end

  def create
    @procedure = @experiment.procedures.create(procedure_params)
    if @procedure.valid?
      redirect_to [@experiment, @procedure]
    else
      render :new
    end
  end

  def edit
    @procedure = find_procedure
  end

  def update
    @procedure = find_procedure
    @procedure.update(procedure_params)
    redirect_to [@experiment, @procedure]
  end

  def destroy
    @procedure = find_procedure
    @procedure.destroy
    redirect_to @experiment
  end

  private
    def find_procedure
      Procedure.find(params[:id])
    end

    def find_experiment
      @experiment = Experiment.find(params[:experiment_id])
    end

    def procedure_params
      params.require(:procedure).permit(:experiment_id, :instructions)
    end
end
