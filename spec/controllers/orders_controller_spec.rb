require "rails_helper"
include CartsHelper
RSpec.describe OrdersController, type: :controller do
  let(:user_test){FactoryBot.create :user, confirmed_at: Time.zone.now}
  let(:order_test){FactoryBot.create :order, user_id: user_test.id}
  let(:order_test2){FactoryBot.create :order}
  let(:product_test){FactoryBot.create :product}
  let(:product_test2){FactoryBot.create :product}
  before do
    sign_in user_test
  end

  describe "GET #index" do
    it "should show all the order" do
      get :index
      expect(assigns(:orders)).to eq [order_test]
    end
  end

  describe "GET #new" do
    before do
      session[:carts] = {product_test.id => 2}
    end

    it "should show list product in cart" do
      get :new
      expect(assigns(:products_in_cart)).to include(product_test => 2)
    end
  end

  describe "POST #create" do
    context "when invalid params" do
      before do
        post :create, params:{order: {order_address: ""}}
      end
      it "should flash danger message" do
        expect(flash[:danger]).to eq I18n.t("order_fails")
      end
      it "should redirect to checkout" do
        expect(response).to redirect_to checkout_path
      end
    end
  end
end
