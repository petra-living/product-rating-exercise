require 'rails_helper'

RSpec.describe RatingController, type: :request do
  describe "GET /index" do
    context "when the product exists" do
      context "when there are ratings" do
        let!(:product_rating) { create(:product_rating) }

        it "renders json with the product ratings" do
          get "/product/#{product_rating.product_id}/product_ratings", :params => { :id => product_rating.product_id }

          expect(JSON.parse(response.body).length).to eq(1)
          expect(response.status).to eq(200)
        end
      end

      context "when there are no ratings" do
        let!(:product) { create(:product) }

        it "renders json with the product ratings" do
          get "/product/#{product.id}/product_ratings", :params => { :id => product.id }

          expect(JSON.parse(response.body).length).to eq(0)
          expect(response.status).to eq(200)
        end
      end

      context "when provided proper sorting variables" do
        let!(:product_rating1) { create(:product_rating, :created_at => Time.new(2022, 2, 2, 10, 0)) }
        let!(:product_rating2) { create(:product_rating, :created_at => Time.new(2022, 2, 2, 10, 1), :product_id => product_rating1.product_id) }

        it "renders json with the product ratings" do
          get "/product/#{product_rating1.product_id}/product_ratings", :params => { :id => product_rating1.product_id, :sort_by => "created_at", :sort_order => "desc" }

          expect(JSON.parse(response.body).length).to eq(2)
          expect(JSON.parse(response.body).first["author"]).to eq(product_rating2.author)
          expect(response.status).to eq(200)
        end
      end

      context "when provided improper sorting variables" do
        let!(:product_rating1) { create(:product_rating, :created_at => Time.new(2022, 2, 2, 10, 0)) }
        let!(:product_rating2) { create(:product_rating, :created_at => Time.new(2022, 2, 2, 10, 1), :product_id => product_rating1.product_id) }

        it "renders json with the product ratings" do
          get "/product/#{product_rating1.product_id}/product_ratings", :params => { :id => product_rating1.product_id, :sort_by => "created_attt", :sort_order => "descccc" }

          expect(JSON.parse(response.body)["message"]).to eq(described_class::PRODUCT_RATING_SORT_ERROR_MESSAGE)
          expect(response.status).to eq(400)
        end
      end
    end

    context "when the product does not exist" do
      it "renders json with an error message and 400 " do
        get "/product/asdf12344321/product_ratings", :params => { :id => "asdf12344321" }

        expect(JSON.parse(response.body)["message"]).to eq(described_class::PRODUCT_DOES_NOT_EXIST_ERROR_MESSAGE)
        expect(response.status).to eq(404)
      end
    end
  end

  describe "POST /create" do
    context "when provided correct paramters" do
      let!(:product) { create(:product) }

      it "saves a new rating" do
        expect(product.product_ratings.length).to eq(0)
        post "/product/#{product.id}/product_rating", :params => { :id => product.id, :author => "Baker", :rating => 3, :review_title => "Title" }

        expect(JSON.parse(response.body)["id"]).not_to be(nil)
        expect(response.status).to eq(200)
      end
    end

    context "when provided incorrect paramters" do
      let!(:product) { create(:product) }

      it "saves a new rating" do
        expect(product.product_ratings.length).to eq(0)
        post "/product/#{product.id}/product_rating", :params => { :id => product.id, :author => "Baker" }

        expect(JSON.parse(response.body)["message"]).not_to be(described_class::PRODUCT_RATING_SAVE_ERROR_MESSAGE)
        expect(response.status).to eq(400)
      end
    end
  end
end
