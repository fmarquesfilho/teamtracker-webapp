class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.string :gh_organization
      
      t.timestamps
    end
  end
end
