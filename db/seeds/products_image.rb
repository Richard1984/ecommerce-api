Product.all.each{ |p|
  s = 'product' + p[:id].to_s + '.jpg'
  file = './db/product/' + s
  begin
    p.images.attach(io: File.open(file), filename:s )
    puts "img prod done "+ s
  rescue => e
    puts e
  end
}
puts "Product image added"