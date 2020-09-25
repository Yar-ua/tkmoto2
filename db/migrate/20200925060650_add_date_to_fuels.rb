class AddDateToFuels < ActiveRecord::Migration[6.0]
  def change
    add_column :fuels, :date, :date
  end
end
