class CreateStataRepairs < ActiveRecord::Migration[5.0]
  def change
    create_table :stata_repairs do |t|

      t.string		:type
      t.string		:note
      t.numeric		:price
      t.references	:bike

      t.timestamps
    end
  end
end
