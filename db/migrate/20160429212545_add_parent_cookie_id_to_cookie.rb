class AddParentCookieIdToCookie < ActiveRecord::Migration
  def change
    add_column :cookies, :parent_cookie_id, :integer
  end
end
