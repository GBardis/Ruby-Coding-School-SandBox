class CreateAdminsettings < ActiveRecord::Migration[5.1]
  def up
    create_table :adminsettings do |t|

      t.timestamps
    end
  end

  def down
    drop_table :adminsettings
  end
end
