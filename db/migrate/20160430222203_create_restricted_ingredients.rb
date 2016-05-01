class CreateRestrictedIngredients < ActiveRecord::Migration
  def change
    create_table :diets_ingredients do |t|
      t.references :diet, index: true, foreign_key: true
      t.references :ingredient, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
