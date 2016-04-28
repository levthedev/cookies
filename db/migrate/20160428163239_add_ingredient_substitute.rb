class AddIngredientSubstitute < ActiveRecord::Migration
  def self.up
    create_table :substitutions, id: false do |t|
      t.integer :ingredient_id
      t.integer :ingredient_sub_id
    end

    add_index(:substitutions, [:ingredient_id, :ingredient_sub_id], :unique => true)
    add_index(:substitutions, [:ingredient_sub_id, :ingredient_id], :unique => true)
  end

  def self.down
    remove_index(:substitutions, [:ingredient_sub_id, :ingredient_id])
    remove_index(:substitutions, [:ingredient_id, :ingredient_sub_id])
    drop_table :substitutions
  end
end
