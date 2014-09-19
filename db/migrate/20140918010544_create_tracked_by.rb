class CreateTrackedBy < ActiveRecord::Migration
  def change
    create_table :tracked_bies, id: false do |t|
      t.references :team
      t.references :repo
      
      t.timestamps
    end
  end
end
