class UsersController < ApplicationController
  # Méthode qui récupère le potin concerné et l'envoie à la view show (show.html.erb) pour affichage
   def show
     @user = User.find(params[:id])
     @gossips = @user.gossips if @user.gossips.present?
   end
 
   # Méthode qui récupère tous les potins et les envoie à la view index (index.html.erb) pour affichage
   def index
     @users = User.all
   end
 
 
 end
 
 