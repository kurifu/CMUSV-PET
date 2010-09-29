class Project < ActiveRecord::Base
  validates_uniqueness_of :name
  validates_presence_of :lifecycle, :name
end
