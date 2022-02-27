require "rails_helper"

RSpec.describe Product, type: :model do
  describe "Associations" do
    it{is_expected.to belong_to(:category)}
    it{is_expected.to have_many(:order_details).dependent(:destroy)}
    it{is_expected.to have_many(:orders).through(:order_details)}
  end

  describe "Validations" do
    before {FactoryBot.build(:product)}
    context "name" do
      it{is_expected.to validate_presence_of(:name)}
      it{is_expected.to validate_length_of(:name).is_at_most(Settings.str_length)}
    end

    context "description" do
      it{is_expected.to validate_presence_of(:description)}
    end

    context "quantity" do
      it{is_expected.to validate_presence_of(:quantity)}
      it{is_expected.to validate_numericality_of(:quantity).only_integer.is_greater_than(Settings.zero)}
    end

    context "price" do
      it{is_expected.to validate_presence_of(:price)}
      it{is_expected.to validate_numericality_of(:quantity).is_greater_than(Settings.zero)}
    end

    context "unit" do
      it{is_expected.to validate_presence_of(:unit)}
    end
  end

  describe "scope" do
    let(:product){FactoryBot.create :product}
    describe ".search_by_name" do
      context "when found" do
        it "should search product by name" do
          expect(Product.search_by_name(product.name)).to eq [product]
        end
      end

      context "when not found" do
        it "should be empty" do
          expect(Product.search_by_name("compalicate_string")).to eq []
        end
      end
    end
  end
end
