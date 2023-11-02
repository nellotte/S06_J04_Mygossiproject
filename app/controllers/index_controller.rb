class HomeController < ApplicationController
  def index
    Gossip.all
  end
end
