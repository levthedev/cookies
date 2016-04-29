class CreateCookies < ActiveRecord::Migration
  def change
    create_table :cookies do |t|
      t.string :name
      t.timestamps null: false
    end
  end
end
