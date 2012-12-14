# coding: utf-8
class Badge < ActiveRecord::Base
  belongs_to :badge_set

  attr_accessible :company, :name, :profession, :surname
end
