require 'rails_helper'

RSpec.describe Cookie, type: :model do
  let(:cookie) { Cookie.create!(name: "basic")                                    }
  let(:butter) { Ingredient.create!(name: "butter", calories: 200, price: 200)    }
  let(:salt)   { Ingredient.create!(name: "salt", calories: 10, price: 300)       }
  let(:flour)  { Ingredient.create!(name: "flour", calories: 50, price: 500)      }
  let(:choc)   { Ingredient.create!(name: "chocolate", calories: 300, price: 700) }

  before(:each) do
    cookie.cookies_ingredients << CookieIngredient.create!(ingredient: flour)
    cookie.cookies_ingredients << CookieIngredient.create!(ingredient: salt)
  end

  it "validates presence of name" do
    bad_cookie = Cookie.create

    expect(bad_cookie.errors[:name]).to eq(["can't be blank"])
    expect(cookie.errors.any?).to be(false)
  end

  it "has ingredients through cookies_ingredients" do
    expect(cookie.ingredients.length).to be(2)
    expect(cookie.ingredients).to include(flour)
  end

  it "rejects ingredients that are not allowed by a diet" do
    gluten_free = Diet.create!(name: "gluten free")
    gluten_free.restricted_ingredients << flour
    gf_cookie = Cookie.create!(name: "gf cookie", parent_cookie: cookie)
    gf_cookie.diets << gluten_free
    expect(gf_cookie.all_ingredients).to_not include(flour)
  end

  describe("parent/child cookies") do
    let!(:sugar_cookie)     { Cookie.create!(name: "sugar_cookie") }
    let!(:choc_cookie)      { Cookie.create!(name: "chocolate")    }

    before(:each) do
      sugar_cookie.cookies_ingredients << CookieIngredient.create!(ingredient: butter)
      sugar_cookie.cookies_ingredients << CookieIngredient.create!(ingredient: salt)
      sugar_cookie.update!(parent_cookie: cookie)
      low_sodium = Diet.create!(name: "low sodium")
      low_sodium.restricted_ingredients << salt
      choc_cookie.update!(parent_cookie: sugar_cookie)
      choc_cookie.diets << low_sodium
      choc_cookie.cookies_ingredients << CookieIngredient.create!(ingredient: choc)
    end

    it "can have a parent cookie and many child cookies" do
      vegan = Cookie.create!(name: "vegan")
      paleo = Cookie.create!(name: "paleo")
      sugar_cookie.child_cookies << vegan
      sugar_cookie.child_cookies << paleo

      expect(cookie.child_cookies).to include(sugar_cookie)
      expect(sugar_cookie.child_cookies).to include(vegan, paleo)
      expect(vegan.parent_cookie).to eq(sugar_cookie)
      expect(paleo.parent_cookie).to eq(sugar_cookie)
    end

    it "traverses it's parents to find all of it's allowed ingredients" do
      expect(choc_cookie.all_ingredients).to include(butter, flour, choc)
      expect(choc_cookie.all_ingredients).to_not include(salt)
    end

    describe "helper methods" do
      it "sums up all the calories of allowed ingredients" do
        expect(choc_cookie.calories).to eq(550)
      end

      it "sums up the price of allowed ingredients" do
        expect(choc_cookie.price).to eq(1400)
      end
    end
  end
end
