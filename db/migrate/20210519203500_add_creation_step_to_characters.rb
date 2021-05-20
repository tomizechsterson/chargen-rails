class AddCreationStepToCharacters < ActiveRecord::Migration[6.1]
  def change
    add_column :characters, :creation_step, :integer, default: 0
  end
end
