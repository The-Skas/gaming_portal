class Tictactoe < ActiveRecord::Base
  attr_accessible :o_id, :x_game_state, :x_id

  has_many :tictactoe_moves

WIN_MOVES = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
public
   def self.create_and_setup
        t = Tictactoe.create
        (0..8).each do  |i|
            mv=t.moves.new
            mv.square_n = i
            mv.move = 0
            mv.player = ""
            mv.save
        end
        t.x_game_state = ""
        t.save
        return t
    end

 def get_winner
    @x_moves=[]
    @o_moves = []
    self.moves.sort!.each do |square|
        if (square.player.upcase == 'X')
            @x_moves.push(square.square_n)
        elsif (square.player.upcase =='O')
            @o_moves.push(square.square_n)
        end
    end
    #Checks if X or O have won or drawn
    @winner = calc_game_state(@x_moves, @o_moves)

    return @winner
    binding.pry
 end
    #giving my fingers a break
    def moves
        self.tictactoe_moves
    end

    def calc_game_state x_moves,o_moves
        winner = nil
         WIN_MOVES.each do |win_move|
            if (win_move & x_moves == win_move)
                winner = 'X'
                self.x_game_state = "Win"
                self.save
                #X has one. Set game state to X has won,
                #Get the X's Use
            elsif (win_move & o_moves == win_move)
                winner='O'
                self.x_game_state = "Lose"
                self.save
                #Do the same stuff
            end
            #Checks if draw if no winner is available
            if (winner == nil)
                if (x_moves.size + o_moves.size >= 9)
                    binding.pry
                    self.x_game_state = "Draw"
                    winner = "none"
                    self.save
                    #Set Draw
                end
            end
        end
        return winner
    end
    #Returns the greatest move number in the joint relationship between Tictactoe
    #and tictactoe_moves
    def last_move
        binding.pry if $debug
        #the last line is always returned... Learn your shiz.
        self.moves.first(:conditions => ["move = ?", self.moves.maximum("move")])
    end

    def move_by_square(number)
        self.moves.where("square_n = #{number}").first
    end

    def game_over?
        if self.x_game_state == ""
            return false
        else
            return true
        end
    end

    # update the users move into the database if it is his turn , also determines if its nil that means
    # its the first move on the board. So automatically initializes 'O' to be last played. But it isnt so.
    def update_tictactoe params
        if self.last_move.move == 0
            @last_move_n = 0
            @last_played = 'O'
        else
            @last_move_n = self.last_move.move
            @last_played = self.last_move.player
        end

        if @last_played == params[:player]
           return false
        elsif !params[:player].blank?
          #Update the relevant square with the X value.
          #There cant be multiple squares with the same number.
          @move = self.move_by_square(params[:square])
          @move.player = params[:player]
          @move.move = @last_move_n + 1
          @move.save
          self.moves.sort!
        end
        return true
    end
end
