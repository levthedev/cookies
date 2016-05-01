require 'rails_helper'

RSpec.describe Diet, type: :model do
  let(:diet)  { Diet.create!(name: "vegan")      }
  let(:milk)  { Ingredient.create!(name: "milk") }
  let(:eggs)  { Ingredient.create!(name: "eggs") }

  before(:each) do
    diet.restricted_ingredients << milk
    diet.restricted_ingredients << eggs
  end

  it "has restricted_ingredients through diets_ingredients" do
    expect(diet.diets_ingredients.length).to be(2)
    expect(diet.diets_ingredients.first.ingredient).to eq(milk)
  end

  it "can check for allowed ingredients" do
    lettuce = Ingredient.create!(name: "lettuce")
    expect(diet.allowed_ingredient?(lettuce)).to be(true)
    expect(diet.allowed_ingredient?(milk)).to be(false)
  end
end
