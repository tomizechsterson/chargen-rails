class AddStatsToCharacters < ActiveRecord::Migration[6.1]
  def change
    add_column :characters, :str, :integer, default: 0
    add_column :characters, :dex, :integer, default: 0
    add_column :characters, :con, :integer, default: 0
    add_column :characters, :int, :integer, default: 0
    add_column :characters, :wis, :integer, default: 0
    add_column :characters, :chr, :integer, default: 0
  end
end
