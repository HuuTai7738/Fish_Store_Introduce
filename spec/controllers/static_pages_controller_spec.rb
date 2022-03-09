require "rails_helper"
RSpec.describe StaticPagesController, type: :controller do
  let(:product_test){FactoryBot.create :product}
  let(:category_test){FactoryBot.create :category}

  describe "GET #home" do
    it "should show the product" do
      get :home
      expect(assigns(:products)).to eq [product_test]
    end

    it "should show the list category" do
      get :home
      expect(assigns(:categories)).to eq [category_test]
    end
  end
end
