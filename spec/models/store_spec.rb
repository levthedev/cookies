require 'rails_helper'

RSpec.describe Store, type: :model do
  let(:store) { Store.create!(name: "grocery store") }

  it "responds to ingredients and store_ingredients" do
    expect(store).to respond_to(:ingredients)
    expect(store).to respond_to(:store_ingredients)
  end

  it "has many ingredients through store_ingredients" do
    flour = Ingredient.create!(name: "flour")
    salt = Ingredient.create!(name: "salt")
    store.ingredients << flour
    store.ingredients << salt

    expect(store.ingredients).to include(flour, salt)
  end
end
