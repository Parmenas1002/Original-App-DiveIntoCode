class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :name
      t.text :description
      t.string :image
      t.references :user, foreign_key: true
      t.string :director
      t.integer :duration, default:false
      t.boolean :is_paying, default:false
      t.integer :cost, default: 0
      t.timestamps
    end
  end
end
