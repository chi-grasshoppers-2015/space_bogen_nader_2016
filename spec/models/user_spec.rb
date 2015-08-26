require "rails_helper"


RSpec.describe User, :type => :model do
  let(:new_user) { User.create(name: "test", email: "test@dbc.edu", password: "123")}

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:hashed_password) }
    it { should validate_presence_of(:position) }

    describe "validates uniqueness of email" do
      subject { User.new(name: "Test Name", password: "123") }
      it { should validate_uniqueness_of(:email) }
    end

    it { should allow_value("matt@dbc.edu").for(:email)}
    it { should_not allow_value("matt@gmail.com").for(:email)}
    it { should_not allow_value("dbc.edu@matt").for(:email)}

    it { should allow_value("staff").for(:position)}
    it { should allow_value("faculty").for(:position)}
    it { should_not allow_value("janitor").for(:position)}
  end


  describe "set_defaults" do
    it "sets the default position to staff" do
      expect(new_user.position).to eq("staff")
    end
  end

  describe "authenticate" do
    it "returns a user when provided valid credentials" do
      expect(User.authenticate(new_user.email, "123")).to eq(new_user)
    end

    it "returns nil when provided invalid credentials" do
      expect(User.authenticate(new_user.email, "234")).to be nil
    end
  end

  describe "faculty?" do
    it "returns true when a user is faculty" do
      new_user.position = "faculty"
      expect(new_user.faculty?).to be true
    end

    it "returns false when a user is not faculty" do
      new_user.position = "staff"
      expect(new_user.faculty?).to be false
    end
  end


end
