require "rails_helper"
RSpec.describe Admin::UsersController, type: :controller do
  let(:user_test){FactoryBot.create :user, role: 1, confirmed_at: Time.zone.now}
  before do
    sign_in user_test
  end
  describe "GET #index" do
    it "should show all the user" do
      get :index
      expect(assigns(:user)).to eq [user_test]
    end
  end
end
