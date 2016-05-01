class Diet < ActiveRecord::Base
  has_many :diets_ingredients
  has_many :restricted_ingredients, through: :diets_ingredients, source: :ingredient
  has_many :cookies_diets
  has_many :cookies, through: :cookies_diets

  def allowed_ingredient?(ingredient)
    restricted_ingredients.include?(ingredient) ? false : true
  end
end
