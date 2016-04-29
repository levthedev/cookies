class Ingredient < ActiveRecord::Base
  validates :name, presence: true

  has_and_belongs_to_many :substitutes,
                          class_name: "Ingredient",
                          join_table: :substitutions,
                          foreign_key: :ingredient_id,
                          association_foreign_key: :substitution_id,
                          dependent: :destroy


  def add_substitute(ingredient)
    unless self.substitutes.include?(ingredient) || ingredient == self
      self.substitutes << ingredient
    end

    unless ingredient.substitutes.include?(self) || ingredient == self
      ingredient.substitutes << self
    end
  end
end
