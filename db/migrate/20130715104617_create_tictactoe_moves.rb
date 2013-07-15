class CreateTictactoeMoves < ActiveRecord::Migration
  def change
    create_table :tictactoe_moves do |t|
      t.integer :tictactoe_id
      t.integer :square_n
      t.integer :move
      t.string :player

      t.timestamps
    end
  end
end
