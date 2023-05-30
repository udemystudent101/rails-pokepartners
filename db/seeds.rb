# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'open-uri'
require 'json'
require 'faker'

services = ["soin", "transport-air", "transport-terre", "transport-eau", "chasse", "pêche", "pompier", "police", "garde du corps"]
json_file = URI.open("https://api-pokemon-fr.vercel.app/api/v1/gen/1").read
data = JSON.parse(json_file)

5.times do
  user = User.new(
    email: Faker::Internet.email,
    password: ("a".."z").to_a.sample(9)
  )
  if user.save
    rand(3..6).times do
      id = rand(1..150)
      pokemon = Pokemon.new(
        name: data[id]["name"]["fr"],
        nature: data[id]["types"][0]["name"],
        category: services.sample,
        price_by_day: rand(50..400)
      )
      pokemon.user = user
      pokemon.save
    end
  else
    p user.errors.messages
  end
end



# Faker::Name.name
# Faker::Games::SuperSmashBros.fighter
