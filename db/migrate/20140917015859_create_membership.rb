class CreateMembership < ActiveRecord::Migration
  def change
    create_table :memberships, id: false do |t|
      t.references :team
      t.references :user
      
      t.timestamps
    end
  end
end
