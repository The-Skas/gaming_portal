class TictactoesController < ApplicationController
  def index
  end

  def create
    @tictactoes = Recipe.new
  end

  def update
  end
end
