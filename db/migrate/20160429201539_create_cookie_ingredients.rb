class CreateCookieIngredients < ActiveRecord::Migration
  def change
    create_table :cookies_ingredients do |t|
      t.boolean :allowed, null: false, default: true
      t.references :ingredient, index: true, foreign_key: true
      t.references :cookie, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
