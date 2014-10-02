class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :gh_login
      
      t.timestamps
    end
  end
end
