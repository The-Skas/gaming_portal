class TictactoeMove < ActiveRecord::Base
  belongs_to :tictactoe
  attr_accessible :tictactoe_id, :move, :player, :square_n

    def last_move
        self.order("move DESC").first
    end
end
