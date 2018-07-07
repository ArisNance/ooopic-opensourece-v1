class AddInfoToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :admin, :boolean, default: false
    add_column :photos, :category_id, :string
  end
end
