class Ingredient < ActiveRecord::Base
  validates :name, presence: true

  has_and_belongs_to_many :substitutes,
                          class_name: "Ingredient",
                          join_table: :substitutions,
                          foreign_key: :ingredient_id,
                          association_foreign_key: :ingredient_sub_id

  def add_substitute(ingredient)
    self.substitutes << ingredient unless self.substitutes.include? ingredient
    ingredient.substitutes << self unless ingredient.substitutes.include? self
  end
end
