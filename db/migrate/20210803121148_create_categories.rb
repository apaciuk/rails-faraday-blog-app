class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :description
      t.belongs_to :posts
      t.boolean :display_in_navbar, default: true


      t.timestamps
    end
  end
end
