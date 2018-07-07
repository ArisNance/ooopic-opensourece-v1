class CreateTags < ActiveRecord::Migration
  def change
    drop_table 'tags' unless !ActiveRecord::Base.connection.table_exists? 'tags'
    
    create_table :tags do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
