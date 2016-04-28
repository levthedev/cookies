require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  let(:ingredient) do
    ingredient_attributes = { name: "sugar", calories: 400, price: 700 }
    Ingredient.create!(ingredient_attributes)
  end

  it "validates presence of name" do
    bad_ingredient = Ingredient.create

    expect(bad_ingredient.errors[:name]).to eq(["can't be blank"])
    expect(ingredient.errors.any?).to be(false)
  end

  describe "substitutes" do
    it "responds to substitutes" do
      expect(ingredient).to respond_to(:substitutes)
    end

    it "adds substitutes bi-directionally" do
      sub_ingredient = Ingredient.create! name: "splenda"
      ingredient.add_substitute(sub_ingredient)

      expect(ingredient.substitutes).to include(sub_ingredient)
      expect(sub_ingredient.substitutes).to include(ingredient)
    end
  end
end
