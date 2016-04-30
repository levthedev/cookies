class Cookie < ActiveRecord::Base
  has_many :cookies_ingredients, -> { where allowed: true }
  has_many :ingredients, through: :cookies_ingredients
  belongs_to :parent_cookie, :class_name => "Cookie", :foreign_key => :parent_cookie_id
  has_many :child_cookies, :class_name => "Cookie", :foreign_key => :parent_cookie_id

  def all_ingredients
    @ingredients = ingredients
    if parent_cookie
      @ingredients += parent_cookie.all_ingredients
    end
    @ingredients
  end

  def calories
    all_ingredients.reduce(0) { |memo, ing| memo += ing.calories.to_i }
  end
end
