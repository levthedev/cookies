class Cookie < ActiveRecord::Base
  has_many :cookies_ingredients, -> { where allowed: true }
  has_many :ingredients, through: :cookies_ingredients
end
