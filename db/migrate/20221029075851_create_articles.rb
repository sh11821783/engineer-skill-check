class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.integer :author
      t.references :employee, null: false, foreign_key: true
      t.timestamps
    end
  end
end
