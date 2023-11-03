class UsersController < ApplicationController
  # Méthode qui récupère le potin concerné et l'envoie à la view show (show.html.erb) pour affichage
  def show
    @user = User.find(params[:id])
    if @user #vérifie si @user est défini et n'est pas nil. Si @user est nil, cela signifie qu'aucun utilisateur correspondant à l'ID donné n'a été trouvé dans la base de données.
      if @user.gossips.present? #vérifie si l'utilisateur a des gossips associés. 
        @gossips = @user.gossips #Si l'utilisateur a des gossips associés, cette ligne attribue ces gossips à la variable d'instance @gossips.
      else
        @gossips = [] #nous initialisons @gossips comme un tableau vide pour éviter que @gossips ne soit nil. Cela garantit que vous pouvez itérer sur @gossips sans déclencher d'erreurs.
      end
    else
      # Traitez le cas où l'utilisateur n'a pas été trouvé (par exemple, redirigez vers une page d'erreur)
    end
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
      remember(@user) # Crée le cookie de mémorisation
      log_in(@user) # Connecte l'utilisateur
      redirect_to home_path # Redirige vers la page de connexion 
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
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :city, :age, :description)
  end
end