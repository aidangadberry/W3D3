class FixShortenedUrls < ActiveRecord::Migration[5.1]
  def change
    drop_table :shortened_urls
    
    create_table :shortened_urls do |t|
      t.string :short_url, :long_url, null: false
      t.integer :user_id
      t.timestamps
    end
    
    add_index :shortened_urls, :user_id
    add_index :shortened_urls, :long_url, unique: true
  end
end
