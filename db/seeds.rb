# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'
Faker::Config.locale = 'fr'

#Tag.destroy_all
Comment.destroy_all
Gossip.destroy_all
User.destroy_all
City.destroy_all


10.times do 
  City.create!(
    name: Faker::Address.city,
    zip_code: Faker::Address.zip
   )
end

10.times do 
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = "#{first_name.downcase}.#{last_name.downcase}@email.com"

  User.create!(
    first_name: first_name,
    last_name: last_name,
    email: email,
    description: Faker::Lorem.sentence(word_count: 5),
    age: Faker::Number.within(range: 18..65),
    city: City.all.sample,
    password: first_name, # Utilisez le prénom de super-héros comme mot de passe
    password_confirmation: first_name
  )
end

20.times do 
  Gossip.create!(
    title: Faker::Book.title,
    content: Faker::Quote.matz,
    user: User.all.sample
  )
end

City.create(
  name: "Paris",
  zip_code: "75011")

  paris_city = City.find_by(name: "Paris", zip_code: "75011")

User.create(
  first_name: "Nelly",
  last_name: "Guerin",
  city: paris_city,
  description: Faker::Lorem.sentence(word_count: 5),
  email: "nelly.guerin@email.com",
  age: "36",
  password: "nelly",             # Utilisez le prénom de super-héros comme mot de passe
  password_confirmation: "nelly"
)

# 10.times do
#   Tag.create!(
#     title: Faker::Book.genre 
#   )
# end

# Gossip.all.each do |gossip|
#   rand(1..5).times do 
#     GossipTag.create!(
#       gossip: gossip,
#       tag: Tag.all.sample
#     )
#   end
# end

# User.all.each do |user|
#   rand(1..5).times do
#     recipient = User.where.not(id: user.id).sample
#     PrivateMessage.create!(
#       content: Faker::Quote.matz,
#       sender: user,
#       recipient: recipient
#     )
#   end
# end
contrepetries =[
  "Il faudrait une bonne purge à cette vaisselle!",
  "Ma belle-mère admire les rossignols du caroubier.",
  "Votre père a l'air mutin.", 
  "L'Empereur est arrivé à pied par la Chine.",
  "Est-ce un feu de poutre?", 
  "Mammouth écrase les prix.", 
  "C'est ici qu'on pendit le fuselage de l'aviatrice.",
  "Les étudiantes admiraient le factum du recteur.", 
  "Les laborieuses populations du Cap.", 
  "La cuvette est pleine de bouillon.", 
  "Le scorpion est malade.", 
  "Quel beau métier: professeur!", 
  "Elle est folle de la messe.", 
  "Dès qu'on touche à son petit banc, cet enfant boude", 
  "A la vue des Nippons, la Chine se soulève.", 
  "Glisser dans la piscine.", 
  "Taisez-vous en bas!", 
  "Ma soeur taille des jupes au Pirée.", 
  "Pour bien dîner, il faut être peu.", 
  "Auberge de Vendée.", 
]
Gossip.all.each do |gossip|
  3.times do
    Comment.create!(
      content: contrepetries.sample, # Utiliser un générateur de contrepétries si disponible
      user: User.where.not(id: gossip.user_id).sample,
      gossip: gossip
    )
  end
end

# 20.times do
#   user = User.all.sample 
#   likable = [Gossip, Comment].sample.all.sample 

#   Like.create(user: user, likable: likable)
# end