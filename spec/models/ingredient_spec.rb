require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  let(:ingredient) { Ingredient.create!(name: "sugar") }

  it "validates presence of name" do
    bad_ingredient = Ingredient.create

    expect(bad_ingredient.errors[:name]).to eq(["can't be blank"])
    expect(ingredient.errors.any?).to be(false)
  end

  describe "substitutes" do
    let(:substitute) { Ingredient.create! name: "splenda" }
    before(:each)    { ingredient.add_substitute(substitute) }

    it "responds to substitutes" do
      expect(ingredient).to respond_to(:substitutes)
    end

    it "can have many substitutes" do
      new_substitute = Ingredient.create! name: "raw sugar"
      ingredient.add_substitute(new_substitute)

      expect(ingredient.substitutes.length).to eq(2)
    end

    it "adds substitutes bi-directionally" do
      expect(ingredient.substitutes).to include(substitute)
      expect(substitute.substitutes).to include(ingredient)
    end

    it "doesn't let itself to be set as a substitute for itself" do
      expect(ingredient.substitutes.length).to be(1)
      ingredient.add_substitute(ingredient)
      expect(ingredient.substitutes.length).to be(1)
    end

    it "doesn't allow repeat substitutes" do
      expect(ingredient.substitutes.length).to be(1)
      ingredient.add_substitute(substitute)
      expect(ingredient.substitutes.length).to be(1)
    end
  end

  describe "cookies_ingredients" do
    it "has many cookies through cookies_ingredients" do
      gf_cookie = Cookie.create!(name: "gluten free")
      vegan_cookie = Cookie.create!(name: "vegan")

      ingredient.cookies << gf_cookie
      ingredient.cookies << vegan_cookie

      expect(ingredient.cookies.length).to be(2)
      expect(ingredient.cookies).to include(gf_cookie, vegan_cookie)
    end
  end
end
