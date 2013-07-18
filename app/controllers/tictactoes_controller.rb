$chat_counter =0
class TictactoesController < ApplicationController
  def index
    redirect_to tictactoe_url, method: :post
  end

  def create

    # @tictactoe = Tictactoe.new
    # @tictactoe.init
    $chat_counter += 1
    @tictactoe = Tictactoe.create_and_setup
    # $chat_counter +=1
    @tictactoe.x_id = session[:user_id]
    @tictactoe.save
    session[:player] = "X"
    binding.pry
    binding.pry if $debug
    redirect_to tictacto_path(@tictactoe)
  end

  def update
    #Checks self state
    #If self has x won , set the x won variable to true.
    @tictactoe = Tictactoe.find(params[:id])
    if (session[:user_id] == @tictactoe.x_id || @tictactoe.o_id)
      if (@tictactoe.game_over?)
        binding.pry
      else
        unless @tictactoe.update_tictactoe(params)
          flash[:alert] = "Its not your turn yet."
        end
        @winner = @tictactoe.get_winner
      end
      redirect_to tictacto_url(@tictactoe)
    else
      flash[:alert] = "You dont have permission to access this game!"
      redirect_to root
    end
  end

  def show
    @tictactoe = Tictactoe.find(params[:id])
  end

  def join
    @tictactoe = Tictactoe.find(params[:id])

    if (@tictactoe.x_id != session[:user_id])
      session[:player] = 'O'
      @tictactoe.o_id = session[:user_id]
      @tictactoe.save
      redirect_to tictacto_path(@tictactoe)
    else
       flash[:error] = "Hey! You cant play against yourself in this mode. This is a player vs player. \n
       Play against a CPU instead."
       redirect_to root_url
    end

  end

  def expand
    @expand = true
    render 'home/index'
  end

  def contract
    @expand = nil
    render 'home/index'
  end
end
