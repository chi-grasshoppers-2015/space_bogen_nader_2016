class ProceduresController < ApplicationController
  def show
    @procedure = Procedure.find(procedure_params)
  end

  def new
  end

  def create
  end

  def update
  end

  private
    def procedure_params
      params.require(:procedure).permit(:experiment_id, :instructions)
    end
end
