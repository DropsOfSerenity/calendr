require 'rails_helper'

RSpec.describe Api::V1::HomeworkController, :type => :controller do
  describe "#index" do
    context "when logged in" do
      before :each do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        user = FactoryGirl.create(:user_with_homeworks, homeworks_count: 5)
        sign_in user
      end

      it "should respond with a list of homework" do
        get :index, format: :json
        expect(response.status).to eq 200
        expect(json_response.length).to eq 5
      end
    end
  end

  describe "#create" do
    context "when logged in" do
      before :each do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        user = FactoryGirl.create(:user)
        sign_in user
        @subject = user.subjects.create(name: "Math", color: "#cccccc")
      end

      it "should create homework" do
        allow(Pusher).to receive(:trigger).and_return(true)

        post :create, format: :json, homework: {
          title: "Test Homework",
          subject_id: @subject.id,
          description: "Test Description",
          due_date: Time.now }

        expect(json_response["title"]).to eq "Test Homework"
        expect(json_response["description"]).to eq "Test Description"
      end
    end

    context "when not logged in" do
      it "should return 401" do
        post :create, format: :json, homework: {
          title: "Test Homework",
          subject_id: 1,
          description: "Test Description",
          due_date: Time.now }
        expect(response.status).to eq 401
      end
    end
  end

  describe "#update" do
    context "when logged in" do
      before :each do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        user = FactoryGirl.create(:user)
        sign_in user
      end
      it "should update the homework" do
        homework = FactoryGirl.create(:homework)
        allow(Pusher).to receive(:trigger).and_return(true)
        put :update, id: homework.id, format: :json, homework: { completed_at: Time.now }
        expect(response.status).to eq 204
      end

      it "should respond to bad requests" do
        homework = FactoryGirl.create(:homework)
        put :update, id: homework.id, format: :json, homework: { some_invalid_param: "stuff" }
        expect(response.status).to eq 400
      end
    end
  end

  def json_response
    JSON.parse(response.body)
  end
end
