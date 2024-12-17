class CreateFileUploads < ActiveRecord::Migration[7.1]
  def change
    create_table :file_uploads do |t|
      t.string :title
      t.text :description
      t.string :file_type
      t.string :public_token
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
