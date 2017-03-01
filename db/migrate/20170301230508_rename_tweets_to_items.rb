class RenameTweetsToItems < ActiveRecord::Migration
  def change
    rename_table :tweets, :items
  end
end
