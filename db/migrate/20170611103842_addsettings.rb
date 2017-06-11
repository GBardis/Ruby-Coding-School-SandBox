class Addsettings < ActiveRecord::Migration[5.1]
  def change
    add_column :adminsettings,:preferences,:text
  end
end
