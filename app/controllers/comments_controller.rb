class CommentsController < ApplicationController

  def new
    # Méthode qui crée un commentaire vide et l'envoie à une view qui affiche le formulaire pour 'le remplir' (new.html.erb)
    @comment = Comment.new
  end

  def create
    if session[:user_id]
      @comment = Comment.create!(content: params['content'], user_id: current_user.id, gossip_id: params[:gossip_id])
      #flash[:success] = "Votre commentaire a été publié !"
      redirect_to gossip_path(params[:gossip_id])
    else
      #flash[:alert] = "Vous devez être connecté pour commenter"
      render "/sessions/new"
    end
  end




  def destroy
    @comment = Comment.find_by(id: params[:id])
    
    if @comment
      @gossip= @comment.gossip # Récupérez le gossip associé au commentaire
      @comment.destroy
      redirect_to gossip_path(@gossip), notice: 'Le commentaire a été supprimé avec succès.'
    else
      redirect_to gossip_path, alert: "Le commentaire n'a pas pu être trouvé ou supprimé."
    end
  end

end
