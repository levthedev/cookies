class Ingredient < ActiveRecord::Base
  validates :name, presence: true

  has_and_belongs_to_many :substitutes,
                          class_name: "Ingredient",
                          join_table: :substitutions,
                          foreign_key: :ingredient_id,
                          association_foreign_key: :substitution_id,
                          dependent: :destroy

  has_many :cookies_ingredients
  has_many :cookies, through: :cookies_ingredients
  has_many :store_ingredients
  has_many :stores, through: :store_ingredients

  def add_substitute(ingredient)
    unless substitutes.include?(ingredient) || ingredient == self
      substitutes << ingredient
    end

    unless ingredient.substitutes.include?(self) || ingredient == self
      ingredient.substitutes << self
    end
  end
end
