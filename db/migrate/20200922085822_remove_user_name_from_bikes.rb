class RemoveUserNameFromBikes < ActiveRecord::Migration[6.0]
  def change
    remove_column :bikes, :user_name, :string
  end
end
