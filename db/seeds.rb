# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = User.create!(
  email: 'ab@gmail.com',
  username: 'ab02',
  first_name: 'ahsan', # Tip: Use lowercase snake_case for column names
  last_name: 'bara',
  password: '123654',
  password_confirmation: '123654', # Devise requires this to confirm password
  role: :admin,                    # Sets the enum role to admin
  university_id: nil               # Admins do not belong to a university
)