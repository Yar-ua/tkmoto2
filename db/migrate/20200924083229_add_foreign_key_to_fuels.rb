class AddForeignKeyToFuels < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :fuels, :bikes
  end
end
