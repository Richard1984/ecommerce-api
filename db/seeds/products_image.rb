Product.all.each{ |p|
  s = 'product' + p[:id].to_s + '.jpg'
  file = './db/product/' + s
  p.images.attach(io: File.open(file), filename:s )
}
puts "Product image added"