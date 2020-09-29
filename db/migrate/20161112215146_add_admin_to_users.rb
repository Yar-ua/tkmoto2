class AddAdminToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :admin, :boolean, default: false  #было можно сделать true чтобы дать всем новым юзерам админ права
  end
end
