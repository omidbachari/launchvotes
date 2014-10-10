class CreateNominations < ActiveRecord::Migration
  def change
    create_table :nominations do |t|
      t.string :content, null: false
      t.integer :user_id, null: false
      t.timestamps
    end
  end
end
