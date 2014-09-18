class Repo < ActiveRecord::Base
  has_many :tracked_bies
  has_many :teams, through: :tracked_bies
end