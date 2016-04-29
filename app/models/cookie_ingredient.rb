class CookieIngredient < ActiveRecord::Base
  belongs_to :ingredient
  belongs_to :cookie
end
