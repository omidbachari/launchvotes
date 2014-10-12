class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :uid, null: false
      t.string :provider, null: false
      t.string :username, null: false
      t.string :pic_url, null: false
      t.string :email
      t.string :name
      t.string :role, :string, null: false, default: 'user'
      t.string :github_token
      t.integer :github_team_id

      t.timestamps
    end

    add_index :users, [:uid, :provider], unique: true
  end
end
