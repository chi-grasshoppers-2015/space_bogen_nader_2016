require "rails_helper"


RSpec.describe Experiment, :type => :model do
  let(:new_experiment) { Experiment.create!(title: "test",
                                            hypothesis: "test hypoth",
                                            description: "test desc",
                                            owner_id: 1,
                                            lab_id: 1,
                                            start_date: DateTime.now,
                                            end_date: DateTime.now,
                                            allotted_time: 100) }

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:hypothesis) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:owner_id) }
    it { should validate_presence_of(:lab_id) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
    it { should validate_presence_of(:allotted_time) }

    it { should allow_value("proposed").for(:status)}
    it { should allow_value("active").for(:status)}
    it { should allow_value("complete").for(:status)}
    it { should_not allow_value("finished").for(:status)}

    it "should prevent an experiment to be completed without a conclusion" do
      new_experiment.status = "complete"
      expect(new_experiment).to_not be_valid
    end
  end

  context 'time calculations' do

    before(:each) do
      procedure1 = new_experiment.procedures.create!(instructions: "do this and then do that")
      procedure2 = new_experiment.procedures.create!(instructions: "do that and then do this")
      procedure3 = new_experiment.procedures.create!(instructions: "do that and then do this")

      procedure1.logs.create!(  observation: "nice and cool",
                                            staff_id: 1 ,
                                            time_spent: 1 ,
                                            time_performed: DateTime.now)
      procedure1.logs.create!(  observation: "nice and cool",
                                            staff_id: 1 ,
                                            time_spent: 6.5 ,
                                            time_performed: DateTime.now)

      procedure2.logs.create!(  observation: "nice and cool",
                                            staff_id: 1 ,
                                            time_spent: 2 ,
                                            time_performed: DateTime.now)
      procedure2.logs.create!(  observation: "nice and cool",
                                            staff_id: 1 ,
                                            time_spent: 7.5 ,
                                            time_performed: DateTime.now)
    end

    describe "#hours_spent" do
      it "should calculate the proper hours spent" do
        expect(new_experiment.hours_spent).to eq(17)
      end
    end

    describe "#hours_left" do
      it "should calculate the proper hours left" do
        expect(new_experiment.hours_left).to eq(83)
      end
    end

  end

  context "staff operations" do

    let(:staff1) { User.create!(name: "staff1",
                                email: "staff1@dbc.edu",
                                password: "1234",
                                position: "staff") }
    let(:staff2) { User.create!(name: "staff2",
                                email: "staff2@dbc.edu",
                                password: "1234",
                                position: "staff") }
    let(:staff3) { User.create!(name: "staff3",
                                email: "staff3@dbc.edu",
                                password: "1234",
                                position: "staff") }

    let(:unstaffed_experiment) { Experiment.create!(title: "test2",
                                                    hypothesis: "test2 hypoth",
                                                    description: "test2 desc",
                                                    owner_id: 2,
                                                    lab_id: 2,
                                                    start_date: DateTime.now,
                                                    end_date: DateTime.now,
                                                    allotted_time: 100) }

    before(:each) do
      new_experiment.staffs_experiments.create!(staff_id: staff1.id,
                                                starred: false,
                                                assigned: true)
      new_experiment.staffs_experiments.create!(staff_id: staff2.id,
                                                starred: true,
                                                assigned: true)
      new_experiment.staffs_experiments.create!(staff_id: staff3.id,
                                                starred: true,
                                                assigned: false)
    end

    describe "#assigned_staff" do

      it "returns an array of staff members assigned to the experiment" do
        expect(new_experiment.assigned_staff).to include(staff1, staff2)
      end

      it "doesn't return staff members who aren't assigned to the experiment" do
        expect(new_experiment.assigned_staff).not_to include(staff3)
      end
    end

    describe "starred_staff" do
      it "returns an array of staff members who starred the experiment" do
        expect(new_experiment.starred_staff).to include(staff2, staff3)
      end

      it "doesn't return staff members who haven't starred the experiment" do
        expect(new_experiment.starred_staff).not_to include(staff1)
      end
    end

    describe "staffed?" do
      it "returns true if the experiment has staff assigned to it" do
        expect(new_experiment.staffed?).to be true
      end

      it "returns false if the experiment has no staff assigned to it" do
        expect(unstaffed_experiment.staffed?).to be false
      end
    end
  end

  describe "completed?" do
    it "returns false for an incomplete experiment" do
      expect(new_experiment.completed?).to be false
    end

    it "returns true for a completed experiment" do
      new_experiment.status = "complete"
      expect(new_experiment.completed?).to be true
    end
  end

end
