class AddUniquenessIndexToNominationContent < ActiveRecord::Migration
  def change
    add_index :nominations, [:content, :nominee_id], unique: true
    add_index :nominations, [:content, :nominator_id], unique: true
  end
end
