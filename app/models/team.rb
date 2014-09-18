class Team < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships
  
  has_many :tracked_bies
  has_many :repos, through: :tracked_bies
end