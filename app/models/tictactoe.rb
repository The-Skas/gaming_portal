class Tictactoe < ActiveRecord::Base
  attr_accessible :o_id, :x_game_state, :x_id

  has_many :tictactoe_moves
end
