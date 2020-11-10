class CreateBikeConfigs < ActiveRecord::Migration[6.0]
  def change
    create_table :bike_configs do |t|
      t.integer :oil_change, default: 1000
      t.references :bike, null: false, foreign_key: true

      t.timestamps
    end
  end
end
