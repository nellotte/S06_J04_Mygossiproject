class HomeController < ApplicationController
  def home
    @gossips = Gossip.all
  end
end
