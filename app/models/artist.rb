class Artist < ActiveRecord::Base
  belongs_to :instrument
  has_and_belongs_to_many :concerts
end
