class DropDatabaseStataRepairs < ActiveRecord::Migration[6.0]
  def change
    drop_table :stata_repairs
  end
end
