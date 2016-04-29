require 'rails_helper'

RSpec.describe Cookie, type: :model do
  let(:cookie) { Cookie.create!(name: "sugar cookie") }

  it "has ingredients through cookies_ingredients" do
    butter = Ingredient.create! name: "butter"
    salt = Ingredient.create! name: "salt"
    cookie.ingredients << butter
    cookie.ingredients << salt

    expect(cookie.ingredients.length).to be(2)
    expect(cookie.ingredients).to include(butter)
    expect(cookie.ingredients).to include(salt)
  end

  it "rejects ingredients that are not allowed" do
    forbidden_ingredient = Ingredient.create(name: "dairy")
    forbidden_params = { ingredient_id: forbidden_ingredient.id, allowed: false }
    cookie.cookies_ingredients.create!(forbidden_params)

    expect(cookie.ingredients).not_to include(forbidden_ingredient)
  end
end
