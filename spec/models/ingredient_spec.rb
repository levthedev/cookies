require 'rails_helper'

RSpec.describe Ingredient, type: :model do

  let(:good_ingredient) do
    ingredient_attributes = { name: "sugar", calories: 400, price: 700 }
    Ingredient.create!(ingredient_attributes)
  end

  it "validates presence of name" do
    bad_ingredient = Ingredient.create

    expect(bad_ingredient.errors[:name]).to eq(["can't be blank"])
    expect(good_ingredient.errors.any?).to be(false)
  end
end
