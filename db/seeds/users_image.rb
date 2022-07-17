User.all.each{ |u|
  s = 'user' + u[:id].to_s + '.png'
  file = './db/user/' + s
  begin
    if !u.avatar.attached?
      u.avatar.attach(io: File.open(file), filename:s )
      puts "img prod done "+ s
    end
  rescue => e
    puts e
  end
}
puts "User image added"