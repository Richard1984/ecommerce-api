User.all.each{ |u|
  s = 'user' + u[:id].to_s + '.png'
  file = './db/user/' + s
  begin
    u.avatar.attach(io: File.open(file), filename:s )
    puts "img prod done "+ s
  rescue => e
    puts e
  end
}
puts "User image added"