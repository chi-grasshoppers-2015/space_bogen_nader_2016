class ExperimentsController < ActionController::Base
  def index
    @experiments = Experiment.all
  end

  def show
    @experiment = Experiment.find(params[:id])
  end

  def new
    @experiment = Experiment.new
  end

  def create
    @experiment = Experiment.create(params[:experiment])
    if @experiment.valid?
      redirect_to @experiment
    else
      render :new
    end
  end

  def update
    @experiment = Experiment.find(params[:id])
    @experiment.update(params[:experiment])
    redirect_to @experiment
  end

  def delete
    Experiment.destroy(params[:id])
    redirect_to experiments_path
  end

end
