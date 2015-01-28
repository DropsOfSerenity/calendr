require 'rails_helper'

RSpec.describe Subject, :type => :model do
  describe "validations" do
    it "allows creation of different subjects" do
      user = FactoryGirl.create(:user)
      user.subjects.create(name: "Math", color: "#cccccc")
      valid_subject = user.subjects.new(name: "Literature", color: "#dfdfdf")
      expect(valid_subject).to be_valid
    end

    it "errors when trying to create two subjects of the same name for a user" do
      user = FactoryGirl.create(:user)
      user.subjects.create(name: "Math", color: "#cccccc")
      invalid_subject = user.subjects.new(name: "Math", color: "#cccccc")

      expect(invalid_subject).not_to be_valid
    end

    it "does not error when different users create the same subject name" do
      user = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      user.subjects.create(name: "Math", color: "#cccccc")
      valid_subject = user2.subjects.new(name: "Math", color: "#cccccc")

      expect(valid_subject).to be_valid
      expect(valid_subject.save).to eq true
    end

    it "requires a name" do
      user = FactoryGirl.create(:user)
      invalid_subject = user.subjects.create(name: "", color: "#cccccc")
      expect(invalid_subject).not_to be_valid
      expect(invalid_subject.save).to eq false
    end

    it "requires a color" do
      user = FactoryGirl.create(:user)
      invalid_subject = user.subjects.create(name: "Math", color: "")
      expect(invalid_subject).not_to be_valid
      expect(invalid_subject.save).to eq false
    end
  end

end
