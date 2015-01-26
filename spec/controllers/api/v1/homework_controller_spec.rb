require 'rails_helper'

RSpec.describe Api::V1::HomeworkController, :type => :controller do
  describe "#update" do
    it "should update the homework" do
      homework = FactoryGirl.create(:homework)

      time = Time.now
      put :update, format: :json, id: homework.id, homework: { completed_at: time }

      homework.reload
      expect(homework.completed_at).to eq time
    end
  end

  def json_response
    JSON.parse(response.body)
  end
end
