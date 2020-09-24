class AddVolumeToBike < ActiveRecord::Migration[6.0]
  def change
    add_column :bikes, :volume, :integer
  end
end
