class Project < ActiveRecord::Base
  validates_uniqueness_of :name
  validates_presence_of :name, :lifecycle_id
end
