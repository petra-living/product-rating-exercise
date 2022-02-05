require 'rails_helper'

RSpec.describe RatingController, type: :request do
  describe "GET /index" do
    context "returns the products by average rating descending" do
      let!(:product1) { create(:product) }
      let!(:product2) { create(:product) }

      let!(:product_rating1) { create(:product_rating, :product_id => product1.id, :rating => 1) }
      let!(:product_rating2) { create(:product_rating, :product_id => product2.id, :rating => 5) }
      it "renders json with the products and a 200 " do
        get "/product"

        expect(JSON.parse(response.body).first["id"]).to eq(product2.id)
        expect(JSON.parse(response.body).last["id"]).to eq(product1.id)
        expect(response.status).to eq(200)
      end
    end
  end
end
