# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first)

# Category.create(name: "Carribbean")
# Category.create(name: "American")
# Category.create(name: "Cafe")

# Place.create(name: "14 Parish Restaurant & Rhum Bar", api_place_id: "ic1X0dPQQK7VAJOsvxLYUQ", bar: true, image_url: "https://s3-media3.fl.yelpcdn.com/bphoto/2WYqzwalAfJ0tLlK_cqnYg/o.jpg", lat: 41.799815, lon: -87.584843, category_id: 1)
# Place.create(name: "5 Loaves Eatery", api_place_id: "V4UEL-OmlUHa6-hNpu4N6Q", bar: false, image_url: "https://s3-media1.fl.yelpcdn.com/bphoto/AZBMmKqhw3-prt3v6QJmew/o.jpg", lat: 41.7582923, lon: -87.6147692, category_id: 2)
# Place.create(name: "Ain't She Sweet Cafe", api_place_id: "IRnNJNVlSyhQG0lBfzsZaA", bar: false, image_url: "https://s3-media2.fl.yelpcdn.com/bphoto/99TZgCMxiLxeoLlDLJvL7w/o.jpg", lat: 41.8168655, lon: -87.612947, category_id: 3)
# Place.create(name: "AndySunflower Cafe", api_place_id: "Imy7MhrTq0z-GQ5RjN_USg", bar: false, image_url: "https://s3-media2.fl.yelpcdn.com/bphoto/PmFDIyonCVWAcg8dsW6mtA/o.jpg", lat: 41.713268, lon: -87.682102, category_id: 3)

Place.create(name: "B&B's Ice Cream and Candy", category_id: 3)
Place.create(name: "BigCity CheeseSteaks", category_id: 2)


# User.create(name: "testname", email: "testemail", password_digest: "testdigest")

# Favorite.create(user_id: 1, place_id: 1)
# Favorite.create(user_id: 1, place_id: 2)
# Favorite.create(user_id: 1, place_id: 4)