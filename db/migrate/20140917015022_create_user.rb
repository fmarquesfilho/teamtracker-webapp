class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :gh_login
      t.string :slack_login
      t.references :team
      
      t.timestamps
    end
  end
end
