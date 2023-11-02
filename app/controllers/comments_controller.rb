class CommentsController < ApplicationController
  def index
    Comment.all
  end
end

def show
  @comment = Comment.find(params[:id])
end

def new
  # Méthode qui crée un commentaire vide et l'envoie à une view qui affiche le formulaire pour 'le remplir' (new.html.erb)
  @comment = Comment.new
end

def create
  nelly_guerin = User.find_by(first_name: "Nelly", last_name: "Guerin")
  @gossip = Gossip.find(params[:gossip_id])
  @comment = @gossip.comments.build(content: params[:comment][:content], user: nelly_guerin)

  if @comment.save
    redirect_to gossip_path(@gossip)
    flash[:comment_success] = "Le commentaire a été créé avec succès."
  else
     # Afficher les erreurs en cas d'échec
    puts "$" * 60
    puts @comment.errors.full_messages
    puts "$" * 60
    flash[:comment_error] = "Échec lors de la création du commentaire."
    render "gossips/show"
  end
end


def destroy
  # Méthode qui récupère le potin concerné et le détruit en base
  # Une fois la suppression faite, on redirige généralement vers la méthode index (pour afficher la liste à jour)
  @comment = Comment.find_by(id: params[:id])
  @comment.destroy
  redirect_to gossip_path(@gossip.id), notice: 'Le commentaire a été supprimé avec succès.'
end


