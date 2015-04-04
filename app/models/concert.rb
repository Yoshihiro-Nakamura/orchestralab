class Concert < ActiveRecord::Base
  belongs_to :orchestra
  belongs_to :place
  belongs_to :conductor
  has_and_belongs_to_many :artists
end