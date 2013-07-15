class TictactoeMove < ActiveRecord::Base
  belongs_to :tictactoe
  attr_accessible :tictactoe_id, :move, :player, :square_n
end
