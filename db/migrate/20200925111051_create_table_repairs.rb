class CreateTableRepairs < ActiveRecord::Migration[6.0]
  def change
    create_table :repairs do |t|
      t.string :description
      t.text :note
      t.decimal :price
      t.date :date
      t.references :bike, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
