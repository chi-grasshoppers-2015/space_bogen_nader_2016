class ExperimentsController < ResourcesController
  include UsersHelper

  before_filter :require_faculty, :except => [:show, :index, :star]

  def index
    @experiments = Experiment.all
  end

  def show
    @experiment = find_experiment
    @staffs_experiments = @experiment.staffs_experiments
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

  def edit
    @experiment = find_experiment
  end

  def update
    @experiment = find_experiment
    @experiment.update(experiment_params)
    if !@experiment.valid?
      flash[:error] = @experiment.errors.full_messages.first
      render :edit
    else
      redirect_to @experiment
    end
  end

  def delete
    Experiment.destroy(params[:id])
    redirect_to experiments_path
  end

  def star
    @experiment = find_experiment
    @experiment.staffs_experiments.create!(staff_id: current_user.id, starred: true, assigned: false)
    redirect_to @experiment
  end

  def assign
    @experiment = find_experiment
    @assignment = @experiment.staffs_experiments.find_or_create_by!(staff_id: experiment_params[:staffs])
    @assignment.update_attributes(assigned: true)
    redirect_to @experiment
  end

  private

    def find_experiment
      Experiment.find(params[:id])
    end

    def experiment_params
      params.require(:experiment).permit(:status, :title, :hypothesis, :description, :conclusion, :start_date, :end_date, :owner_id, :lab_id, :allotted_time, :staffs)
    end

    def require_faculty
      redirect_to experiments_path unless current_user.faculty?
    end

end
