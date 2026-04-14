User.find_or_create_by!(email: 'felender7@gmail.com') do |user|
  user.password = 'Tlang126920.!!'
  user.password_confirmation = 'Tlang126920.!!'
  user.first_name = 'Felender'
  user.last_name = 'Nukeri'
  user.role = 'admin'
  user.must_update_password = true
end
