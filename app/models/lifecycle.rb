class Lifecycle < ActiveRecord::Base
  validates_uniqueness_of :name
  validates_presence_of :name

  # FK stored in projects
  has_many :projects
end
