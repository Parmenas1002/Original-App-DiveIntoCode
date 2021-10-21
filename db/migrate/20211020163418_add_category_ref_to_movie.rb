class AddCategoryRefToMovie < ActiveRecord::Migration[5.2]
  def change
    add_reference :movies, :category, foreign_key: true, default: 1
  end
end
