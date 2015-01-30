require 'rails_helper'

RSpec.describe Api::V1::SubjectController, :type => :controller do
  describe "#index" do
    context "with a logged in user with subjects" do
      before :each do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        user = FactoryGirl.create(:user_with_subjects, subjects_count: 5)
        sign_in user
      end

      it "should respond with the users subjects" do
        get :index, format: :json

        expect(response.status).to eq 200
        expect(json_response.length).to eq 5
      end
    end
  end

  describe "#show" do
    context "with a logged in user with subjects" do
      before :each do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @user = FactoryGirl.create(:user_with_subjects, subjects_count: 1)
        sign_in @user
      end

      it "should show the subject" do
        user_subject = @user.subjects.first
        get :show, id: user_subject.id, format: :json

        expect(json_response["name"]).to eq user_subject.name
      end
    end
  end

  describe "#create" do
    context "with a logged in user" do
      before :each do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        user = FactoryGirl.create(:user)
        sign_in user
      end

      it "should create a subject" do
        allow(Pusher).to receive(:trigger).and_return(true)

        post :create, format: :json, subject: {name: "Math", color: "#cccccc"}

        expect(response.status).to be 201
        expect(json_response["name"]).to eq "Math"
        expect(json_response["color"]).to eq "#cccccc"
      end
    end
    context "without a logged in user" do
      it "should return 401" do
        post :create, format: :json, subject: {name: "Math", color: "#cccccc"}
        expect(response.status).to be 401
      end
    end
  end

  def json_response
    JSON.parse(response.body)
  end
end
