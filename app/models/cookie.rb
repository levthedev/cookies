class Cookie < ActiveRecord::Base
  has_many :cookies_ingredients, -> { where allowed: true }
  has_many :ingredients, through: :cookies_ingredients
  belongs_to :parent_cookie, :class_name => "Cookie", :foreign_key => :parent_cookie_id
  has_many :child_cookies, :class_name => "Cookie", :foreign_key => :parent_cookie_id

  def all_ingredients
    @all_ingredients = ingredients || []
    if parent_cookie
      @all_ingredients += parent_cookie.all_ingredients
    end
    @all_ingredients
    # @all_ingredients = ingredients || []
    # parent = parent_cookie
    # while parent
    #   @all_ingredients += parent.ingredients
    #   parent = parent.parent_cookie
    # end
    # @all_ingredients
  end
end
