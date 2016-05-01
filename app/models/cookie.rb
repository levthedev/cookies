class Cookie < ActiveRecord::Base
  validates :name, presence: true
  has_many :cookies_ingredients
  has_many :ingredients, through: :cookies_ingredients
  has_many :cookie_diets
  has_many :diets, through: :cookie_diets
  belongs_to :parent_cookie, :class_name => "Cookie", :foreign_key => :parent_cookie_id
  has_many :child_cookies, :class_name => "Cookie", :foreign_key => :parent_cookie_id

  def all_ingredients
    @ingredients = ingredients
    if parent_cookie
      @ingredients << parent_cookie.all_ingredients
    end
    @ingredients.select { |ing| ing if allowed?(ing) }
  end

  def calories
    all_ingredients.reduce(0) { |memo, ing| memo += ing.calories.to_i }
  end

  def price
    all_ingredients.reduce(0) { |memo, ing| memo += ing.price.to_i }
  end

  def allowed?(ingredient)
    diets.map { |diet| diet.allowed_ingredient?(ingredient) }.all?
  end
end
