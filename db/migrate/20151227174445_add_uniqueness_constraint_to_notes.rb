class AddUniquenessConstraintToNotes < ActiveRecord::Migration
  def change
    add_index :notes, :note_id, :unique => true
  end
end
