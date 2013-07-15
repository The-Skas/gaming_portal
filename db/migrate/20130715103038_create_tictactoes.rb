class CreateTictactoes < ActiveRecord::Migration
  def change
    create_table :tictactoes do |t|
      t.integer :x_id
      t.integer :o_id
      t.string :x_game_state

      t.timestamps
    end
  end
end
