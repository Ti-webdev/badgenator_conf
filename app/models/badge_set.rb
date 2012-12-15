class BadgeSet < ActiveRecord::Base
  has_many :badges

  validates :name, :length => { :minimum => 2, :maximum => 50 }

  attr_accessible :name

  attr_accessible :source
  attr_accessor :source

  attr_accessible :image
  attr_accessor :image
  
  validates :name, presence: true
end