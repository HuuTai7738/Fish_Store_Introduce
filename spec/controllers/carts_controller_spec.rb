require "rails_helper"
include CartsHelper
RSpec.describe CartsController, type: :controller do
  let(:user_test){FactoryBot.create :user, confirmed_at: Time.zone.now}
  let(:order_test){FactoryBot.create :order, user_id: user_test.id}
  let(:order_test2){FactoryBot.create :order}
  let(:product_test){FactoryBot.create :product}

  describe "GET #index" do
    before do
      session[:carts] = {product_test.id => 2}
    end

    it "should show list product in cart" do
      get :index
      expect(assigns(:products_in_cart)).to include(product_test => 2)
    end
  end

  describe "POST #create" do
    context "when id of product invalid" do
      before do
        post :create, params:{id: -1}
      end

      it "should flash danger" do
        expect(flash[:danger]).to eq I18n.t("not_found")
      end

      it "should redirect to cart path" do
        expect(response).to redirect_to carts_path
      end
    end

    context "when id of product invalid but quantity less than 0" do
      before do
        post :create, params:{id: product_test.id, quantity: -1}
      end

      it "should flash danger" do
        expect(flash[:warning]).to eq I18n.t("fails")
      end

      it "should redirect to cart path" do
        expect(response).to redirect_to carts_path
      end
    end

    context "when valid param" do
      before do
        post :create, params:{id: product_test.id, quantity: 2}
      end

      it "should assign @product" do
        expect(assigns(:product)).to eq product_test
      end

      it "should assign @quantity" do
        expect(assigns(:quantity)).to eq 2
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      session[:carts] = {product_test.id => 2}
    end
    context "when valid param" do
      before do
        delete :destroy, params:{id: product_test.id}
      end

      it "should redirect to cart path" do
        expect(response).to redirect_to carts_path
      end
    end
  end
end
