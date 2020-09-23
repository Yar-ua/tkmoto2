class RenameStataFuelsToFuels < ActiveRecord::Migration[6.0]
  def change
    rename_table :stata_fuels, :fuels
  end
end
