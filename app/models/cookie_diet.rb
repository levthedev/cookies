class CookieDiet < ActiveRecord::Base
  belongs_to :cookie
  belongs_to :diet
end
