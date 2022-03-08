require "rails_helper"
RSpec.describe Admin::CategoriesController, type: :controller do
  let(:user_test){FactoryBot.create :user, role: 1, confirmed_at: Time.zone.now}
  let(:category_test){FactoryBot.create :category}

  before do
    sign_in user_test
  end
  describe "GET #index" do
    it "should show all the category" do
      get :index
      expect(assigns(:category)).to eq [category_test]
    end
  end

  describe "GET #new" do
    it "should assign new @category" do
      get :new
      expect(assigns(:category)).to be_a_new(Category)
    end
  end

  describe "POST #create" do
    context "when invalid params" do
      before do
        post :create, params:{category: {name: ""}}
      end
      it "should flash danger message" do
        expect(flash[:danger]).to eq I18n.t("create_fail")
      end
      it "should render new" do
        is_expected.to render_template :new
      end
    end

    context "when valid params" do
      let(:category_params){FactoryBot.attributes_for :category}
      before do
        post :create, params:{category: category_params}
      end
      it "should flash sucess message" do
        expect(flash[:success]).to eq I18n.t("success")
      end
      it "should redirect to list product" do
        expect(response).to redirect_to admin_categories_url
      end
    end
  end
  describe "PATCH #update" do
    context "when incorect params id category" do
      let(:category_params){FactoryBot.attributes_for :category}
      before do
        patch :update, params:{id: -1, category: category_params}
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
        patch :update, params:{id: category_test.id, category: {name: ""}}
      end
      it "should render edit" do
        is_expected.to render_template :edit
      end
    end

    context "when valid params" do
      let(:category_params){FactoryBot.attributes_for :category}
      before do
        patch :update, params:{id: category_test.id, category: category_params}
      end
      it "should flash success message" do
        expect(flash[:success]).to eq I18n.t("success")
      end
      it "should show list products" do
        expect(response).to redirect_to admin_categories_url
      end
    end
  end

  describe "DELETE #destroy" do
    context "when incorect params id category" do
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
        delete :destroy, params:{id: category_test.id}
      end
      it "should flash success message" do
        expect(flash[:success]).to eq I18n.t("success")
      end
    end
  end
end
