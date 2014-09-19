class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.string :gh_organization
      t.string :slack_team_id
      
      t.timestamps
    end
  end
end
