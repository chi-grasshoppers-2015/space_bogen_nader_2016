class LabsController < ActionController::Base
  def index
    @labs = Lab.all
  end

  def show
    @lab = Lab.find(params[:id])
  end
end

