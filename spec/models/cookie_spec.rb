require 'rails_helper'

RSpec.describe Cookie, type: :model do
  let(:cookie)    { Cookie.create!(name: "basic")         }
  let(:butter)    { Ingredient.create! name: "butter"     }
  let(:salt)      { Ingredient.create! name: "salt"       }
  let(:flour)     { Ingredient.create!(name: "flour")     }
  let(:chocolate) { Ingredient.create!(name: "chocolate") }

  it "has ingredients through cookies_ingredients" do
    cookie.cookies_ingredients << CookieIngredient.create!(ingredient: butter)
    cookie.cookies_ingredients << CookieIngredient.create!(ingredient: salt)

    expect(cookie.ingredients.length).to be(2)
    expect(cookie.ingredients).to include(butter)
    expect(cookie.ingredients).to include(salt)
  end

  it "rejects ingredients that are not allowed" do
    forbidden_ingredient = Ingredient.create(name: "dairy")
    forbidden_params     = { ingredient: forbidden_ingredient, allowed: false }
    cookie.cookies_ingredients.create!(forbidden_params)

    expect(cookie.ingredients).not_to include(forbidden_ingredient)
  end

  describe("parent/child cookies") do
    let(:sugar_cookie)     { Cookie.create!(name: "sugar_cookie") }
    let(:chocolate_cookie) { Cookie.create!(name: "chocolate")    }

    it "can have a parent cookie and many child cookies" do
      sugar_cookie.update!(parent_cookie: cookie)
      vegan = Cookie.create!(name: "vegan")
      paleo = Cookie.create!(name: "paleo")
      sugar_cookie.child_cookies << vegan
      sugar_cookie.child_cookies << paleo

      expect(cookie.child_cookies).to include(sugar_cookie)
      expect(sugar_cookie.child_cookies).to include(vegan, paleo)
      expect(vegan.parent_cookie).to eq(sugar_cookie)
      expect(paleo.parent_cookie).to eq(sugar_cookie)
    end

    it "traverses it's parents to find all of it's ingredients" do
      cookie.cookies_ingredients        << CookieIngredient.create!(ingredient: flour)
      sugar_cookie.cookies_ingredients  << CookieIngredient.create!(ingredient: butter)
      sugar_cookie.cookies_ingredients  << CookieIngredient.create!(ingredient: salt)
      sugar_cookie.update!(parent_cookie: cookie)
      chocolate_cookie.update!(parent_cookie: sugar_cookie)
      chocolate_cookie.cookies_ingredients << CookieIngredient.create!(ingredient: chocolate)

      expect(chocolate_cookie.all_ingredients).to include(butter, salt, flour, chocolate)
    end
  end
end
