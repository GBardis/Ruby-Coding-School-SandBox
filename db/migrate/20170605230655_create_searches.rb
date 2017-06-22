class CreateSearches < ActiveRecord::Migration[5.1]
  def up
    create_table :searches do |t|

      t.timestamps
    end
  end

  def down
    drop_table :searches  
  end
end
