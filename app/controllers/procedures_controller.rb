class ProceduresController < ApplicationController
  def show
    @procedure = find_procedure
  end

  def new
    @procedure = Procedure.new
  end

  def create
    @procedure = Procedure.create(procedure_params)
    if @procedure.valid?
      redirect_to @procedure
    else
      render :new
    end
  end

  def update
    @procedure = find_procedure
    @procedure.update(procedure_params)
    redirect_to @procedure
  end

  private
    def find_procedure
      Procedure.find(params[:id])
    end

    def procedure_params
      params.require(:procedure).permit(:experiment_id, :instructions)
    end
end
