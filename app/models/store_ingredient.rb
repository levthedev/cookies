class StoreIngredient < ActiveRecord::Base
  belongs_to :store
  belongs_to :ingredient
end
