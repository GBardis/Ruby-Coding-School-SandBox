class CreateAdminsettings < ActiveRecord::Migration[5.1]
  def change
    create_table :adminsettings do |t|

      t.timestamps
    end
  end
end
