class CitiesController < ApplicationController
  # Méthode qui récupère le potin concerné et l'envoie à la view show (show.html.erb) pour affichage
   def show
     @city = City.find(params[:id])
     @users = @city.users
     @gossips = Gossip.joins(:user).where(users: { city_id: @city.id })
     
   end
 
   # Méthode qui récupère tous les potins et les envoie à la view index (index.html.erb) pour affichage
   def index
     @cities = City.all
   end
 
 
 end
 
 