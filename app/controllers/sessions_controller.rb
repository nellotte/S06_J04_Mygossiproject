class SessionsController < ApplicationController

  def new
  end

  def create
    # Récupérez l'email et le mot de passe depuis les paramètres du formulaire
    email = params[:email]
    password = params[:password]

    # Recherchez un utilisateur en fonction de l'email
    user = User.find_by(email: email)

 # on vérifie si l'utilisateur existe bien ET si on arrive à l'authentifier (méthode bcrypt) avec le mot de passe 
    if user && user.authenticate(password)
      session[:user_id] = user.id
  # redirige où tu veux, avec un flash ou pas
      redirect_to "/home"
      flash[:session_success] = "Connecté avec succès!"
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
      # Afficher les erreurs en cas d'échec
      puts "$" * 60
      puts @user.errors.full_messages
      puts "$" * 60
    end
  end


  def destroy
    session.delete(:user_id)
    redirect_to new_session_path 
    flash[:logout_success] = "Déconnecté avec succès!"
  end

end