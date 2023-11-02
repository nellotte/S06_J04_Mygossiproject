class GossipsController < ApplicationController
 # Méthode qui récupère le potin concerné et l'envoie à la view show (show.html.erb) pour affichage
  def show
    @gossip = Gossip.find(params[:id])
  end

  # Méthode qui récupère tous les potins et les envoie à la view index (index.html.erb) pour affichage
  def index
    @gossips = Gossip.all
  end

  def new
    # Méthode qui crée un potin vide et l'envoie à une view qui affiche le formulaire pour 'le remplir' (new.html.erb)
    @gossip = Gossip.new
  end

  def create
    nelly_guerin = User.find_by(first_name: "Nelly", last_name: "Guerin")
    puts "$" * 60
    puts "ceci est le contenu de params :"
    puts params
    puts "$" * 60

    @gossip = Gossip.new(content: params[:content], title: params[:title], user: nelly_guerin)
    puts @gossip.title
    if @gossip.save
      redirect_to "/home"
      flash[:success] = "Le gossip a été créé avec succès ! I know you love me... XoXo GossipGirl ;-)"
    else
       # Afficher les erreurs en cas d'échec
      puts "$" * 60
      puts @gossip.errors.full_messages
      puts "$" * 60
      render "/gossips/new"
      flash[:error] = "Échec lors de la création du potin."
      if @gossip.errors[:title].include?("can't be blank")
        flash[:error] += "Le titre du potin ne peut pas être vide."
      end
    
      if @gossip.errors[:title].include?("is too short (minimum is 3 characters)")
        flash[:error] += "Le titre du potin est trop court (le minimum est de 3 caractères)."
      end
    
      if @gossip.errors[:title].include?("is too long (maximum is 14 characters)")
        flash[:error] += "Le titre du potin est trop long (le maximum est de 14 caractères)."
      end
    
      if @gossip.errors[:content].include?("can't be blank")
        flash[:error] += "Le contenu du potin ne peut pas être vide."
      end
    end
    
  end

  def edit
    # Méthode qui récupère le potin concerné et l'envoie à la view edit (edit.html.erb) pour affichage dans un formulaire d'édition
    @gossip = Gossip.find(params[:id])
  end

  def update
    # Méthode qui met à jour le potin à partir du contenu du formulaire de edit.html.erb, soumis par l'utilisateur
    # pour info, le contenu de ce formulaire sera accessible dans le hash params
    # Une fois la modification faite, on redirige généralement vers la méthode show (pour afficher le potin modifié)
    @gossip = Gossip.find(params[:id])
    gossip_params = params.require(:gossip).permit(:title, :content)

    if @gossip.update(gossip_params)
      redirect_to gossip_path(@gossip.id) # Rediriger vers la page du gossip modifié
      flash[:modif_success] = "Le potin a été modifié avec succès."
    else
      # Afficher les erreurs en cas d'échec
      puts "$" * 60
      puts @gossip.errors.full_messages
      puts "$" * 60
      flash[:error] = "Échec lors de la création du potin."
      if @gossip.errors[:title].include?("can't be blank")
        flash[:error] += "Le titre du potin ne peut pas être vide."
      end
    
      if @gossip.errors[:title].include?("is too short (minimum is 3 characters)")
        flash[:error] += "Le titre du potin est trop court (le minimum est de 3 caractères)."
      end
    
      if @gossip.errors[:title].include?("is too long (maximum is 14 characters)")
        flash[:error] += "Le titre du potin est trop long (le maximum est de 14 caractères)."
      end
    
      if @gossip.errors[:content].include?("can't be blank")
        flash[:error] += "Le contenu du potin ne peut pas être vide."
      end
      render 'edit' # En cas d'erreur de validation, réafficher le formulaire d'édition
    end
  end

  def destroy
    # Méthode qui récupère le potin concerné et le détruit en base
    # Une fois la suppression faite, on redirige généralement vers la méthode index (pour afficher la liste à jour)
    @gossip = Gossip.find_by(id: params[:id])
    @gossip.destroy
    redirect_to gossips_path, notice: 'Le gossip a été supprimé avec succès.'
  end

end

