class Cookie < ActiveRecord::Base
  validates :name, presence: true
  has_many :cookies_ingredients
  has_many :ingredients, through: :cookies_ingredients
  has_many :cookie_diets
  has_many :diets, through: :cookie_diets
  belongs_to :parent_cookie, :class_name => "Cookie", :foreign_key => :parent_cookie_id
  has_many :child_cookies, :class_name => "Cookie", :foreign_key => :parent_cookie_id

  def all_ingredients(ingredients_memo = [ingredients])
    all_parents.each do |parent|
      ingredients_memo << parent.ingredients.select do |i|
        i if parent.allowed?(i) && allowed?(i) && !ingredients_memo.flatten.include?(i)
      end
    end
    ingredients_memo.flatten
  end

  def all_parents
    parents = [parent_cookie]
    parents << parent_cookie.all_parents if parent_cookie
    parents.flatten.compact
  end

  def allowed?(ingredient)
    diets.map { |diet| diet.allowed_ingredient?(ingredient) }.all?
  end

  def calories
    all_ingredients.reduce(0) { |memo, ing| memo += ing.calories.to_i }
  end

  def price
    all_ingredients.reduce(0) { |memo, ing| memo += ing.price.to_i }
  end
end
