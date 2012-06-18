user = User.find_or_create_by_name('admin') do |user| 
  user.password = '123456'; user.email = 'admin@mail.com'
end

user.roles.find_or_create_by_title(:title => 'admin')

puts 'Admin is created'
