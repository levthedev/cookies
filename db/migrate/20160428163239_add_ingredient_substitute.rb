class AddIngredientSubstitute < ActiveRecord::Migration
  def change
    create_table :substitutions, id: false do |t|
      t.integer :ingredient_id
      t.integer :substitution_id
    end

    add_index(:substitutions, [:ingredient_id, :substitution_id], :unique => true)
    add_index(:substitutions, [:substitution_id, :ingredient_id], :unique => true)
  end
end
