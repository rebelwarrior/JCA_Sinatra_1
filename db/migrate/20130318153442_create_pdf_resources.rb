class CreatePdfResources < ActiveRecord::Migration
  def up
    create_table :pdf_resources do |t|
      t.string :name
      t.string :thumb_url
      t.string :url
      t.date   :vigent
      t.date   :expiry
      t.string :lang
      t.integer :rel
      t.timestamps
    end
  end

  def down
    drop_table :pdf_resources
  end
end
