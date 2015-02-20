class DropGithubTeams < ActiveRecord::Migration
  def up
    drop_table :github_teams
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
