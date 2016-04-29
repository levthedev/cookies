require 'rails_helper'

RSpec.describe CookieIngredient, type: :model do
  it "defaults allowed to true" do
    cookie_ingredient = CookieIngredient.create!
    expect(cookie_ingredient.allowed).to be(true)
  end

  it "doesn't let allowed be set to null" do
    null_error = Proc.new { CookieIngredient.create!(allowed: nil) }
    expect { null_error.call }.to raise_error(/PG::NotNullViolation/)
  end
end
