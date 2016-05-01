class CreateCookieDiets < ActiveRecord::Migration
  def change
    create_table :cookie_diets do |t|
      t.references :cookie, index: true, foreign_key: true
      t.references :diet, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
