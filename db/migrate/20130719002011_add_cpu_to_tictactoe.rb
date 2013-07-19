class AddCpuToTictactoe < ActiveRecord::Migration
  def change
    add_column :tictactoes, :cpu, :boolean
  end
end
