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
      log_in(user)
      # Vérifiez si la case "Se souvenir de moi" est cochée
      # on va cuisiner le cookie pour l'utilisateur
      if params[:remember_me]
        remember(user)
      else
        forget(user)
      end
  # redirige où tu veux, avec un flash ou pas
      redirect_to "/home"
      flash[:session_success] = "Connecté avec succès!"
    else
      flash.now[:session_ko] = 'Les informations de connexion ne sont pas correctes'
      render 'new'
    end
  end


  def destroy
    log_out(current_user)
    redirect_to "/sessions/new"
    flash[:logout_success] = "Déconnecté avec succès!"
  end

end