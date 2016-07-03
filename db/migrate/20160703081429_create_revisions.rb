class CreateRevisions < ActiveRecord::Migration[5.0]
  def change
    create_table :revisions do |t|
      t.string :title
      t.string :slug
      t.string :body
      t.references :page, foreign_key: true
      t.references :profile, foreign_key: true

      t.timestamps
    end
  end
end
