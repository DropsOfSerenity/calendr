require 'rails_helper'

RSpec.describe Api::V1::HomeworkController, :type => :controller do
  describe "#index" do
    it "should return 200" do
      get :index, format: :json
      expect(response).to be_success
    end
  end
end
