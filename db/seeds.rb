
Stripe.api_key = Rails.application.credentials.stripe_secret_key
puts "Stripe api key created"
Shop.create!([
  {singleton_guard: 0, name: "Pippo", surname: "Baudo", social_reason: "Non so cosa e' una ragione sociale", vat_number: "00012300123", address: "Via dei matti 0", sector: "Informatica"}
])
puts "Shop created"

User.create!([
    {firstname: "Ennio ", lastname: "Babati", email: "asd@asd.it", password: "password123", stripe_customer: Stripe::Customer.create()['id']},
    {firstname: "Adelasia ", lastname: "Gritti", email: "asd@asd.com", password: "notapassword", stripe_customer: Stripe::Customer.create()['id']},
    {firstname: "Lara ", lastname: "Sabbatini", email: "keklol@asd.boh", password: "asddsa12", stripe_customer: Stripe::Customer.create()['id']},
    {firstname: "Paolo", lastname: "Sgalambro", email: "ao@ao.it", password: "password", roles_mask: 1, country: "My country changedo", stripe_customer: Stripe::Customer.create()['id']},
    {firstname: "Paolo", lastname: "Tomasini", email: "asdoasdo@pippo.bo", password: "pippopappo", stripe_customer: Stripe::Customer.create()['id']},
    {firstname: "Fiamma", lastname: "Tarchetti", email: "asd12@asd.it", password: "password123", stripe_customer: Stripe::Customer.create()['id']},
    {firstname: "Lazzaro", lastname: "Traetta", email: "asd13@asd.com", password: "notapassword", stripe_customer: Stripe::Customer.create()['id']},
    {firstname: "Giacinto", lastname: "Zanzi", email: "keklol14@asd.boh", password: "asddsa12", stripe_customer: Stripe::Customer.create()['id']},
    {firstname: "Ermes ", lastname: "Vecellio", email: "notadmin15@ao.it", password: "password", stripe_customer: Stripe::Customer.create()['id']},
    {firstname: "Virginia ", lastname: "Montessori", email: "asdoasdo16@pippo.bo", password: "pippopappo", stripe_customer: Stripe::Customer.create()['id']}
])
puts "User created"



Category.create!([
    {name: "Elettronica"},
    {name: "Abbigliamento"},
    {name: "Amnazom fresh"},
    {name: "Film e TV"},
    {name: "Bellezza"}
])
puts "Category created"


Product.create!([
    {name: "Broccoli", availability: 10, price: "1.48", description: "Cavolo broccolo, prodotto filmato da 500g. Conservare in luogo fresco e asciutto.", category_id: 3, available: true},
    {name: "Star il mio brodo di verdure", availability: 0, price: "2.05", description: "Star Il Mio Brodo di Verdure, 1000mlProdotto imballato e provvisto di confezione originale. Articolo nuovo ed imballato.", category_id: 3, available: true},
    {name: "Riso Scotti Risotto Porcino di Stagione", availability: 8, price: "1.69", description: "RISOTTO PORCINO DI STAGIONE: Per te, un risotto che rispetta la tradizione culinaria italiana portata in una ricetta resa ancora più preziosa dalla straordinaria qualità del nostro riso CarnaroliI prodotti Riso Scotti ti accompagnano con Gusto e Benessere in ogni momento della giornata. Con la stessa attenzione con cui tu scegli prodotti sani, noi ci impegniamo a offrirti la miglior qualità per un’alimentazione equilibrata.", category_id: 3, available: true},
    {name: "Abito Estivo da Donna", availability: 8, price: "44.08", description: "Cute Sun Dress: la vestibilità e il design svasato permettono di fluire bene in modo che nasconda bene i fianchi e la pancia bene.
    Stile: senza maniche, doppie cinghie regolabili in staphetti, due tasche laterali, stampa floreale, lunghezza al ginocchio, stile casual, comodo mini abito estivo a trapezio.", category_id: 2, available: true},
    {name: "T-Shirt da Uomo", availability: 99888, price: "22.11", description: "Comfort senza etichette", category_id: 2, available: true},
    {name: "HGDGears Plain Baseball cap", availability: 32, price: "10.5", description: "100% cotone di alta qualità", category_id: 2, available: true},
    {name: "Sciarpa - 100% lino", availability: 69, price: "39.97", description: "Sciarpa per donna, 100% lino", category_id: 2, available: true},
    {name: "Invernale Sciarpa Scialle Pashmina", availability: 18, price: "99.0", description: "La sciarpa da donna è realizzata dai materiali selezionati, 30% in cotone e 70% in poliestere, morbida al tatto, super comoda e calda, resiste al freddo intenso, ti accompagna a trascorrere il freddo inverno.", category_id: 2, available: true},
    {name: "Collana Donna Cuore in Argento", availability: 10, price: "24.07", description: "solo una collana", category_id: 5, available: true},
    {name: "Placcati platino in argento Sterling", availability: 140, price: "66.0", description: "Anello placcato platino", category_id: 5, available: true},
    {name: "The Big Bang Theory, La Serie Completa", availability: 500, price: "40.0", description: "The Big Bang Theory, La Serie Completa", category_id: 4, available: true},
    {name: "Sex And The City - La Serie Completa", availability: 10, price: "25.08", description: "Sex And The City - La Serie Completa", category_id: 4, available: true},
    {name: "Trono di Spade Stagioni 1-8", availability: 2286, price: "53.08", description: "Trono di Spade Stagioni 1-8", category_id: 4, available: true},
    {name: "MAXFIT61 Tastiera meccanica", availability: 13, price: "39.08", description: "MAXFIT61 Tastiera meccanica cablata RGB al 60%, 61 tasti Tastiera da gioco programmabile di tipo C sostituibile a caldo, interruttore blu Outemu, bianco", category_id: 1, available: true},
    {name: "Cooler Master CK352 Tastiera Gaming Meccanica (Layout IT) ", availability: 20, price: "45.52", description: "Cooler Master CK352 Tastiera Gaming Meccanica (Layout IT) - Interruttori Rossi, Retroilluminazione RGB per Tasto e Barre luminose - Formato Completo, Cablato, Keycaps Personalizzabili, QWERTY", category_id: 1, available: true},
    {name: "Coolerplus FC112 USB Optical Wired Mouse  ", availability: 200, price: "11.99", description: "Coolerplus FC112 USB Optical Wired Mouse con facile clic per ufficio e casa, 1000DPI, Premium e portatile, compatibile con Windows PC, Laptop, Desktop, Notebook(nero)", category_id: 1, available: true}
])
puts "Product created"


Order.create!([
    {user_id: 1}, 
    {user_id: 1}, 
    {user_id: 4}, 
    {user_id: 4}, 
    {user_id: 5}, 
    {user_id: 5}
])
puts "Order created"


OrderProduct.create!([
  {order_id: 1, product_id: 10, quantity: 10}, 
  {order_id: 1, product_id: 13, quantity: 1}, 
  {order_id: 2, product_id: 5, quantity: 100}, 
  {order_id: 2, product_id: 1, quantity: 1},
  {order_id: 3, product_id: 6, quantity: 10},
  {order_id: 3, product_id: 7, quantity: 1},
  {order_id: 4, product_id: 16, quantity: 150},
  {order_id: 4, product_id: 5, quantity: 7},
  {order_id: 5, product_id: 6, quantity: 2},
  {order_id: 5, product_id: 13, quantity: 7},
  {order_id: 6, product_id: 5, quantity: 98},
  {order_id: 6, product_id: 13, quantity: 12}
])

puts "OrderProduct created"



Cart.create!([
  { user_id: 4, product_id: 1, quantity: 2 },
  { user_id: 4, product_id: 3, quantity: 2 },
  { user_id: 1, product_id: 5, quantity: 2 },
  { user_id: 2, product_id: 5, quantity: 2 },
])
puts "Cart created"