class TictactoesController < ApplicationController
  def index
  end

  def create
    @tictactoe = Tictactoe.new

    @tictactoe.save

    (0..8).each do  |i|
        mv=@tictactoe.tictactoe_moves.new
        mv.square_n = i
        mv.save
    end
    binding.pry if $debug
    redirect_to tictacto_url(@tictactoe)
  end

  def update
  end

  def show
    @tictactoe = Tictactoe.find(params[:id])
  end
end
