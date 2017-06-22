class Addsettings < ActiveRecord::Migration[5.1]
  def up
    add_column :adminsettings,:preferences,:text
  end

  def down
    remove_column :adminsettings,:preferences
  end
end
