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

  def new
  @user = User.new
  end

  def create
    @user = User.new(user_params)
    
      # par defaut tous les nouveaux user sont a paris. Recherche de la ville de Paris ou création si elle n'existe pas
    paris_city = City.find_or_create_by(name: "Paris", zip_code: "75011")
    @user.city = paris_city

    if @user.save
      redirect_to new_session_path # Redirige vers la page de connexion 
    else
      # Afficher les erreurs en cas d'échec
      puts "$" * 60
      puts @user.errors.full_messages
      puts "$" * 60
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end