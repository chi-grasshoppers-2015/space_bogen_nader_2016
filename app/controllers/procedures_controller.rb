class ProceduresController < ResourcesController
  def show
    @procedure = find_procedure
  end

  def new
    @procedure = Procedure.new
    @experiment = Experiment.find(params[:experiment_id])
  end

  def create
    @procedure = Procedure.create(procedure_params)
    if @procedure.valid?
      redirect_to @procedure
    else
      render :new
    end
  end

  def edit
    @procedure = Procedure.find(params[:id])
  end

  def update
    @procedure = find_procedure
    @procedure.update(procedure_params)
    redirect_to @procedure
  end

  def destroy
    @procedure = Procedure.find(params[:id])
    @experiment = @procedure.experiment
    @procedure.destroy
    redirect_to @experiment
  end

  private
    def find_procedure
      Procedure.find(params[:id])
    end

    def procedure_params
      params.require(:procedure).permit(:experiment_id, :instructions)
    end
end
