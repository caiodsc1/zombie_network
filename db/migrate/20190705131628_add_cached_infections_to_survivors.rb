class AddCachedInfectionsToSurvivors < ActiveRecord::Migration[5.2]
  def change
    change_table :survivors do |t|
      t.integer :cached_votes_up, default: 0
    end

    # Uncomment this line to force caching of existing votes
    # Post.find_each(&:update_cached_votes)
  end
end
