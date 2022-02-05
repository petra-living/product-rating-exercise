# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id          :uuid             not null, primary key
#  description :string
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_products_on_name  (name) UNIQUE
#

require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "#average_rating" do
    subject { product.average_rating }

    context "when there are no ratings" do
      let(:product) { build(:product) }

      it "returns 0" do
        expect(subject).to eq(0)
      end
    end

    context "when there are ratings" do
      let(:product) { create(:product) }
      let!(:product_rating1) { create(:product_rating, :product_id => product.id, :rating => 5) }
      let!(:product_rating2) { create(:product_rating, :product_id => product.id, :rating => 1) }

      it "corretly calculates the average" do
        expect(subject).to eq(3)
      end
    end
  end
end
