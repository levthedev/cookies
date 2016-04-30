class CreateStoreIngredients < ActiveRecord::Migration
  def change
    create_table :store_ingredients do |t|
      t.references :store, index: true, foreign_key: true
      t.references :ingredient, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
