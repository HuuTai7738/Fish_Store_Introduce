require "rails_helper"
RSpec.describe Admin::OrdersController, type: :controller do
  let(:user_test){FactoryBot.create :user, role: 1, confirmed_at: Time.zone.now}
  let(:order_test){FactoryBot.create :order}
  before do
    sign_in user_test
  end

  describe "GET #index" do
    it "should show all the order" do
      get :index
      expect(assigns(:order)).to eq [order_test]
    end
  end

  describe "PATCH #update" do
    context "when incorect params status" do
      let(:order_params){FactoryBot.attributes_for :order, status: "incotect_status"}
      before do
        patch :update, params:{id: order_test.id, order: order_params}
      end
      it "should flash danger" do
        expect(flash[:danger]).to eq I18n.t("wrong_status")
      end
    end

    context "when corect params status" do
      let(:order_params){FactoryBot.attributes_for :order, status: "accepted"}
      before do
        patch :update, params:{id: order_test.id, order: order_params}
      end
      it "should redirect to admin orders" do
        expect(response).to redirect_to admin_orders_path
      end
    end
  end
end
