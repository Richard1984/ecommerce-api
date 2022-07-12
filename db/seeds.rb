Shop.create!([
  {singleton_guard: 0, name: "Pippo", surname: "Baudo", social_reason: "Non so cosa e' una ragione sociale", vat_number: "00012300123", address: "Via dei matti 0", sector: "Informatica"}
])
User.create!([
    {email: "asd@asd.it", password: "password123"},
    {email: "asd@asd.com", password: "notapassword"},
    {email: "keklol@asd.boh", password: "asddsa12"},
    {email: "ao@ao.it", password: "password", country: "My country changedo", firstname: "Paolo", lastname: "Paoloni", roles_mask: 1},
    {email: "notadmin@ao.it", password: "password"},
    {email: "asdoasdo@pippo.bo", password: "pippopappo", firstname: "Pippo", lastname: "Pappo"}
])
Category.create!([
    {name: "categoria1"},
    {name: "categoria 2"},
    {name: "categoria modificata"}
])
Product.create!([
    {name: "prodotto1", availability: 10, price: "24.08", description: "Un prodotto importante", category_id: 1, available: true},
    {name: "provaNoCat", availability: 0, price: "0.0", description: "", category_id: 1, available: true},
    {name: "nuovo prodotto incredibile", availability: 8, price: "44.08", description: "Questo prodotto non esiste (forse) (:", category_id: 1, available: true},
    {name: "Prodotto modificato", availability: 8, price: "44.08", description: "Anche la descrizione e' stata modificata", category_id: 1, available: true},
    {name: "pempsi", availability: 99888, price: "22.11", description: "Pempsi", category_id: 1, available: true},
    {name: "cola", availability: 32, price: "10.5", description: "Non e' coca-cola", category_id: 1, available: true},
    {name: "doge", availability: 69, price: "0.1", description: "Non vale molto", category_id: 1, available: true},
    {name: "elon musk", availability: 1, price: "99999.0", description: "Non ha piu' soldi per twitter e si e' messo in vendita", category_id: 2, available: true},
    {name: "un cane", availability: 10, price: "24.07", description: "Il tuo migliore amico", category_id: 2, available: true},
    {name: "prodotto bello", availability: 140, price: "66.0", description: "E' bello", category_id: 2, available: true},
    {name: "tastiera meccanica", availability: 0, price: "10000.0", description: "Costa troppo ma qualcuno la compra di sicuro", category_id: 1, available: true},
    {name: "ennesimo prodotto", availability: 10, price: "25.08", description: "Uffa", category_id: 1, available: true},
    {name: "prodotto2", availability: 2286, price: "1.08", description: "Un prodotto importante", category_id: 2, available: true},
    {name: "prodotto3", availability: 13, price: "5.08", description: "Un prodotto importante", category_id: 1, available: true},
    {name: "prodotto4", availability: 0, price: "25.08", description: "Un prodotto importante", category_id: 1, available: true}
])
Review.create!([
    {stars: 3, comments: "Commento modificato", product_id: 1, user_id: 1},
    {stars: 5, comments: "cringe", product_id: 1, user_id: 2}
])
Vote.create!([
  {likes: false, review_id: 1, user_id: 3}
])
Order.create!([
    {user_id: 1},
    {user_id: 1},
    {user_id: 4},
    {user_id: 4},
    {user_id: 5},
    {user_id: 5}
])
OrderProduct.create!([
  {order_id: 1, product_id: 10, quantity: 10},
  {order_id: 1, product_id: 13, quantity: 1},
  {order_id: 2, product_id: 5, quantity: 10},
  {order_id: 2, product_id: 1, quantity: 1},
  {order_id: 3, product_id: 6, quantity: 10},
  {order_id: 3, product_id: 7, quantity: 1},
  {order_id: 4, product_id: 6, quantity: 2},
  {order_id: 4, product_id: 5, quantity: 7},
  {order_id: 5, product_id: 6, quantity: 2},
  {order_id: 5, product_id: 13, quantity: 7},
  {order_id: 6, product_id: 5, quantity: 98},
  {order_id: 6, product_id: 13, quantity: 12}
])
Cart.create!([
  { user_id: 4, product_id: 1, quantity: 2 },
  { user_id: 4, product_id: 3, quantity: 2 },
])