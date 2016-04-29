require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  let(:ingredient) do
    Ingredient.create!(name: "sugar")
  end

  it "validates presence of name" do
    bad_ingredient = Ingredient.create

    expect(bad_ingredient.errors[:name]).to eq(["can't be blank"])
    expect(ingredient.errors.any?).to be(false)
  end

  describe "substitutes" do
    let!(:substitute) { Ingredient.create! name: "splenda" }
    # before(:each) { ingredient.add_substitute(substitute) }

    it "responds to substitutes" do
      expect(ingredient).to respond_to(:substitutes)
    end

    it "adds substitutes bi-directionally" do
      ingredient.add_substitute(substitute)

      expect(ingredient.substitutes).to include(substitute)
      expect(substitute.substitutes).to include(ingredient)
    end

    it "doesn't let itself to be set as a substitute for itself" do

    end
  end
end
