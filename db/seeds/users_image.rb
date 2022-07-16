User.all.each{ |u|
  s = 'user' + u[:id].to_s + '.png'
  file = './db/user/' + s
  u.avatar.attach(io: File.open(file), filename:s )
}
puts "User image added"