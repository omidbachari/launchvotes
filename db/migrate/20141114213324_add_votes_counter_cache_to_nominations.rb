class AddVotesCounterCacheToNominations < ActiveRecord::Migration
  def up
    add_column :nominations, :votes_count, :integer, null: false, default: 0

    Nomination.all.pluck(:id).each do |id|
      Nomination.reset_counters(id, :votes)
    end
  end

  def down
    remove_column :nominations, :votes_count
  end
end
