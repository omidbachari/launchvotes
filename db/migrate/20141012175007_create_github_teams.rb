class CreateGithubTeams < ActiveRecord::Migration
  def change
    create_table :github_teams do |t|
      t.string :name, null: false
      t.integer :tid, null: false
      t.timestamps
    end
  end
end
