class TrackedBy < ActiveRecord::Base
  belongs_to :team
  belongs_to :repo
end