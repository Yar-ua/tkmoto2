class CreateOils < ActiveRecord::Migration[6.0]
  def change
    create_table :oils do |t|
      t.integer :oil_change
      t.references :bike, null: false, foreign_key: true

      t.timestamps
    end
  end
end
