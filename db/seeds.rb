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

json_file_1 = URI.open("https://api-pokemon-fr.vercel.app/api/v1/gen/1").read
api_1 = JSON.parse(json_file_1)

json_file_2 = URI.open("https://pokebuildapi.fr/api/v1/pokemon/generation/1").read
api_2 = JSON.parse(json_file_2)

5.times do
  user = User.new(
    email: Faker::Internet.email,
    name: Faker::Name.name,
    password: ("a".."z").to_a.sample(9)
  )

  if user.save
    rand(3..6).times do
      id = rand(1..150)
      pokemon = Pokemon.new(
        name: api_1[id]["name"]["fr"],
        nature: api_1[id]["types"][0]["name"],
        category: services.sample,
        price: rand(50..400),
        image_url: api_2[id]["image"]
      )
      pokemon.user = user
      pokemon.save
    end
  else
    p user.errors.messages
  end
end



# Faker::Games::SuperSmashBros.fighter
