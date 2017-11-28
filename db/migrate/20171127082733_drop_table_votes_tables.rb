class DropTableVotesTables < ActiveRecord::Migration
  def change
    drop_table :votes_tables
  end
end
