# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
sugar_cookie     = Cookie.create!(name: 'Sugar')
chocolate_cookie = Cookie.create!(name: 'Chocolate')
vegan_cookie     = Cookie.create!(name: 'Vegan')
paleo_cookie     = Cookie.create!(name: 'Paleo')

sugar     = Ingredient.create!(name: 'sugar', calories: 200, price: 200)
chocolate = Ingredient.create!(name: 'chocolate', calories: 600, price: 600)
flour     = Ingredient.create!(name: 'flour', calories: 100, price: 300)
salt      = Ingredient.create!(name: 'salt', calories: 10, price: 200)
eggs      = Ingredient.create!(name: 'eggs', calories: 250, price: 400)

sugar_cookie.ingredients     << sugar
sugar_cookie.ingredients     << flour
chocolate_cookie.ingredients << chocolate
vegan_cookie.ingredients     << salt
paleo_cookie.ingredients     << eggs

chocolate_cookie.update!(parent_cookie: sugar_cookie)
vegan_cookie.update!(parent_cookie: chocolate_cookie)
paleo_cookie.update!(parent_cookie: chocolate_cookie)

vegan_diet = Diet.create!(name: "vegan")
vegan_diet.restricted_ingredients << eggs
vegan_diet.restricted_ingredients << chocolate

paleo_diet = Diet.create!(name: "paleo")
paleo_diet.restricted_ingredients << flour
paleo_diet.restricted_ingredients << chocolate

vegan_cookie.diets << vegan_diet
paleo_cookie.diets << paleo_diet

bodega  = Store.create!(name: "corner store", address: "515 E 82nd St")
grocery = Store.create!(name: "grocery store", address: "515 W 82nd St")

bodega.ingredients << chocolate
bodega.ingredients << eggs

grocery.ingredients << sugar
grocery.ingredients << salt
grocery.ingredients << flour
