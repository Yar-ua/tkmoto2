class AddForeignKeyToBikes < ActiveRecord::Migration[6.0]
  def change
    add_reference :bikes, :user, foreign_key: true #, null: false
  end
end
