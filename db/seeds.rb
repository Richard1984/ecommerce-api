# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Category.create!(name: "categoria1")
Category.create!(name: "categoria bella")
Product.create!(name: "prodotto1", category_id: 1, availability: 2313, price: 24.08, description: "Un prodotto importante")
Product.create!(name: "prodotto3", category_id: 1, availability: 13, price: 5.08, description: "Un prodotto importante")
Product.create!(name: "prodotto4", category_id: 1, availability: 113, price: 25.08, description: "Un prodotto importante")
Product.create!(name: "pempsi", category_id: 1, availability: 100000, price: 22.11, description: "Pempsi")
Product.create!(name: "cola", category_id: 1, availability: 32, price: 10.50, description: "Non e' coca-cola")
Product.create!(name: "doge", category_id: 1, availability: 69, price: 0.1, description: "Non vale molto")
Product.create!(name: "elon musk", category_id: 2, availability: 1, price: 99999, description: "Non ha piu' soldi per twitter e si e' messo in vendita")
Product.create!(name: "un cane", category_id: 2, availability: 10, price: 24.07, description: "Il tuo migliore amico")
Product.create!(name: "prodotto bello", category_id: 2, availability: 140, price: 66, description: "E' bello")
Product.create!(name: "tastiera meccanica", category_id: 1, availability: 0, price: 10000, description: "Costa troppo ma qualcuno la compra di sicuro")
Product.create!(name: "ennesimo prodotto", category_id: 1, availability: 10, price: 25.08, description: "Uffa")
User.create!(firstname: "Jeff", lastname: "Mbezos", email: "asd@asd.it", password: "not_a_password")
User.create!(firstname: "Jeffo", lastname: "Mbezoso", email: "asd324@asd.it", password: "not_4a_password")
Cart.create!(user_id:1)
Order.create!(user_id:1)
Order.create!(user_id:2)