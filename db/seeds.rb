# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Category.create!(name: "categoria1")
Product.create!(name: "prodotto1", category_id: 1, availability: 10, price: 24.08, description: "Un prodotto importante")
User.create!(email: "asd@asd.it", password: "not_a_password")