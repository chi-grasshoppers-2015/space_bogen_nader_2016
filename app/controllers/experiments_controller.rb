class ExperimentsController < ActionController::Base
  def index
    @experiments = Experiment.all
  end

  def show
    @experiment = find_experiment
  end

  def new
    @experiment = Experiment.new
  end

  def create
    @experiment = Experiment.create(experiment_params)
    if @experiment.valid?
      redirect_to @experiment
    else
      render :new
    end
  end

  def update
    @experiment = find_experiment
    @experiment.update(experiment_params)
    redirect_to @experiment
  end

  def delete
    Experiment.destroy(params[:id])
    redirect_to experiments_path
  end

  private

    def find_experiment
      Experiment.find(params[:id])
    end

    def experiment_params
      params.require(:experiment).permit(:status, :title, :hypothesis, :description, :conclusion, :start_date, :end_date, :owner_id, :lab_id)
    end

end
