class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name
      t.string :format
      t.integer :length
      t.integer:size

      t.timestamps
    end
  end
end
