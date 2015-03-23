class CreateRevisions < ActiveRecord::Migration
  def change
    create_table :revisions do |t|
      t.integer :page_id
      t.integer :user_id
      t.string :user_ip

      t.text :body
      t.string :engine

      t.timestamps null: false
    end
  end
end
