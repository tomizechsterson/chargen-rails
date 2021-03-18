class CreateCharacters < ActiveRecord::Migration[6.1]
  def change
    create_table :characters do |t|
      t.string :name, limit: 32, null:false

      t.timestamps
    end
  end
end
