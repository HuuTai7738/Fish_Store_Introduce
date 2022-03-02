require "rails_helper"
include SessionsHelper
RSpec.describe Admin::ProductsController, type: :controller do
  let(:user_test){FactoryBot.create :user, role: 1}
  let(:product_test){FactoryBot.create :product}

  before do
    log_in user_test
  end
  describe "GET #index" do
    it "should show all the product" do
      get :index
      expect(assigns(:product)).to eq [product_test]
    end
  end

  describe "GET #new" do
    it "should assign new @product" do
      get :new
      expect(assigns(:product)).to be_a_new(Product)
    end
  end

  describe "POST #create" do
    context "when invalid params" do
      before do
        post :create, params:{product: {name: ""}}
      end
      it "should flash danger message" do
        expect(flash[:danger]).to eq I18n.t("create_fail")
      end
      it "should render new" do
        is_expected.to render_template :new
      end
    end

    context "when valid params" do
      let(:product_params){FactoryBot.attributes_for :product}
      before do
        post :create, params:{product: product_params}
      end
      it "should flash sucess message" do
        expect(flash[:success]).to eq I18n.t("success")
      end
      it "should redirect to list product" do
        expect(response).to redirect_to admin_products_url
      end
    end
  end

  describe "PATCH #update" do
    context "when incorect params id product" do
      let(:product_params){FactoryBot.attributes_for :product}
      before do
        patch :update, params:{id: -1, product: product_params}
      end
      it "should flash danger" do
        expect(flash[:danger]).to eq I18n.t("not_found")
      end

      it "should redirect to root path" do
        expect(response).to redirect_to root_path
      end
    end

    context "when invalid params" do
      before do
        patch :update, params:{id: product_test.id, product: {name: ""}}
      end
      it "should flash danger message" do
        expect(flash[:danger]).to eq I18n.t("fails")
      end
      it "should render edit" do
        is_expected.to render_template :edit
      end
    end

    context "when valid params with status deactivated" do
      let(:product_params){FactoryBot.attributes_for :product, status: "deactivated"}
      before do
        patch :update, params:{id: product_test.id, product: product_params}
      end
      it "should flash success message" do
        expect(flash[:success]).to eq I18n.t("success")
      end
      it "should show list products" do
        expect(response).to redirect_to admin_products_url
      end
    end
  end

  describe "DELETE #destroy" do
    context "when incorect params id product" do
      before do
        delete :destroy, params:{id: -1}
      end
      it "should flash danger" do
        expect(flash[:danger]).to eq I18n.t("not_found")
      end

      it "should redirect to root path" do
        expect(response).to redirect_to root_path
      end
    end
    context "when delete success" do
      before do
        delete :destroy, params:{id: product_test.id}
      end
      it "should change status the product" do
        expect(product_test.reload.status).to eq "deactivated"
      end
    end
  end
end
