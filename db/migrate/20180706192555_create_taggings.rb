class CreateTaggings < ActiveRecord::Migration
  def change
    drop_table 'taggings' unless !ActiveRecord::Base.connection.table_exists? 'taggings'
    
    create_table :taggings do |t|
      t.belongs_to :tag, index: true, foreign_key: true
      t.belongs_to :photo, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
