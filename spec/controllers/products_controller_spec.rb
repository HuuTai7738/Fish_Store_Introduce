require "rails_helper"
RSpec.describe ProductsController, type: :controller do
  let(:category_test){FactoryBot.create :category}
  let(:product_test){FactoryBot.create :product, category_id: category_test.id }
  let(:product_test2){FactoryBot.create :product, category_id: category_test.id, status: "deactivated" }
  describe "GET #index" do
    it "should assign @category" do
      get :index
      expect(assigns(:categories)).to eq [category_test]
    end

    it "should assign @product with activated product" do
      get :index
      expect(assigns(:products)).to eq [product_test]
    end
  end

  describe "GET #show" do
    context "when invalid params product" do
      before do
        get :show, params:{id: -1}
      end
      it "should flash danger message" do
        expect(flash[:danger]).to eq I18n.t("not_found")
      end
      it "should redirect to home page" do
        expect(response).to redirect_to root_path
      end
    end

    context "when valid params product" do
      before do
        get :show, params:{id: product_test.id }
      end
      it "should assign @product" do
        expect(assigns(:product)).to eq product_test
      end
    end
  end
end
