class BadgeSet < ActiveRecord::Base
  attr_accessible :name

  attr_accessible :source
  attr_accessor :source

  attr_accessible :image
  attr_accessor :image
  
  validates :name, presence: true
end