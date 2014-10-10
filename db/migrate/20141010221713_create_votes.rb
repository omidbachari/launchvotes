class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :nomination_id, null: false
      t.integer :user_id, null: false
    end

    add_index :votes, [:nomination_id, :user_id], unique: true
  end
end
