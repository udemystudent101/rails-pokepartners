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

services = Pokemon::CATEGORIES
details = [
  "c`est un Pokémon de nature joueuse et qui n`accorde pas sa confiance à n`importe qui.",
  "Pour ce qui est du caractère, ce Pokémon est toujours joyeux et généreux. Ce Pokémon n`hésite pas à aider ces semblables",
  "Pokémon mystérieux et énigmatique. Il est difficile d`en dire beaucoup sur son caractère, car il n`a pas été vu dans beaucoup de combats et n`a pas été beaucoup révélé au public."
]

json_file_1 = URI.open("https://api-pokemon-fr.vercel.app/api/v1/gen/1").read
api_1 = JSON.parse(json_file_1)

json_file_2 = URI.open("https://pokebuildapi.fr/api/v1/pokemon/generation/1").read
api_2 = JSON.parse(json_file_2)

Booking.destroy_all
puts "booking destroyed"
Pokemon.destroy_all
puts "pokemon destroyed"
User.destroy_all
puts "user destroyed"

sacha = User.new(
    email: "sacha@pika.com",
    name: "Sacha",
    password: "secret"
  )

sacha.save!

puts "user created"

natures = []

5.times do
  user = User.new(
    email: Faker::Internet.email,
    name: Faker::Name.name,
    password: ("a".."z").to_a.sample(9)
  )

  if user.save
    rand(3..10).times do
      id = rand(0..150)
      nature = api_1[id]["types"][0]["name"]
      pokemon = Pokemon.new(
        name: api_1[id]["name"]["fr"],
        nature: api_1[id]["types"][0]["name"],
        category: services.sample,
        price: rand(50..400),
        image_url: api_2[id]["image"],
        details: details.sample
      )
      natures << nature unless Pokemon::NATURE.include?(nature)
      pokemon.user = user
      pokemon.save
    end
  else
    p user.errors.messages
  end
end

sacha = User.where(name: "Sacha")[0]
sacha_team = [16, 0, 5, 6]
sacha_team.each do |id|
  nature = api_1[id]["types"][0]["name"]
  pokemon = Pokemon.new(
    name: api_1[id]["name"]["fr"],
    nature: api_1[id]["types"][0]["name"],
    category: services.sample,
    price: rand(50..400) + rand(1000..3000),
    image_url: api_2[id]["image"],
    details: details.sample
  )
  pokemon.user = sacha
  pokemon.save
end

pikachu_id = 24
nature = api_1[pikachu_id]["types"][0]["name"]
pokemon = Pokemon.new(
  name: api_1[pikachu_id]["name"]["fr"],
  nature: api_1[pikachu_id]["types"][0]["name"],
  category: services.sample,
  price: rand(10000..99999),
  image_url: api_2[pikachu_id]["image"],
  details: details.sample
)
pokemon.user = sacha
pokemon.save
array = Pokemon.all - Pokemon.where(user_id: User.where(name: "Sacha")[0])
array.shuffle.sample(4).each do |pokemon|
  start = rand(1..7)
  endD = rand(3..14)
  booking = Booking.new(
    start_date: Date.today + start.day,
    end_date: Date.today + start.day + endD.day
  )
  booking.user = sacha
  booking.pokemon = pokemon
  booking.save!
end
