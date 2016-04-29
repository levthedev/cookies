class AddIngredientSubstitute < ActiveRecord::Migration
  def change
    create_table :substitutions, id: false do |t|
      t.integer :ingredient_id
      t.integer :substitution_id
    end
  end
end
