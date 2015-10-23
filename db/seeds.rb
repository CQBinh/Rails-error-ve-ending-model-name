puts 'Creating User'
User.create!(
  name: 'CQBinh'
)
puts 'Creating ThankGive'
ThankGive.create!(
  name: 'My Appreciation',
  user_id: 1
)
