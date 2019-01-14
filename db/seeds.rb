# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.create!(name: "Tram Le",
             email: Figaro.env.email,
             password: Figaro.env.password,
             password_confirmation: Figaro.env.password,
             role: 1)

#User
30.times do |n|
  name  = Faker::Name.name
  email = "tramle-#{n+1}@gmail.com"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end

#Publisher
10.times do |n|
  name = Faker::Name.name
  address = Faker::Address.full_address
  Publisher.create!(name: name, address: address)
end

# Author
20.times do |n|
  name = Faker::Name.name
  profile = Faker::Lorem.sentence(5)
  Author.create!(name: name, profile: profile)
end

# Category
name= ["Sach Tieng Viet", "Van hoc", "Tieu thuyet", "Tinh cam",
  "Kinh te", "Ngan Hang", "Marketing",
  "Sach Tieng Anh", "Chung Chi", "TOEIC", "IELTS",
  "Du hoc", "Trong nuoc", "Ngoai nuoc"]
parent_id = ["", 1, 2, 2, 1, 5, 5, "", 8, 9, 9, 8, 12, 12]
path = ["1-", "1-2-", "1-2-3-", "1-2-4-", "1-5-", "1-5-6-", "1-5-7-", "8-",
  "8-9-", "8-9-10-", "8-9-11-", "8-12-", "8-12-13-", "8-12-14-"]
for i in 0..13 do
  Category.create!(name: name[i], parent_id: parent_id[i], path: path[i])
end

# Book
# id = [2,3,6,7,8,9,4,5,4]
for i in 1..10 do
  3.times do |n|
    name = Faker::Book.title
    content =Faker::Lorem.sentence(10)
    Book.create!(name: name, category_id: i, author_id: i, publisher_id: i,
      content: content, number_of_pages: 200, year: 2018, number_of_books: 5)
  end
end
