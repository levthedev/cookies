class Store < ActiveRecord::Base
  has_many :store_ingredients
  has_many :ingredients, through: :store_ingredients
end
