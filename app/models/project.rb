# The projects table contains the following column
#   id            integer
#   name          varchar(255)
#   description   varchar(255)
#   lifecycle     varchar(255)
#   status        varchar(255)
#
# In the project model class, it will validate the presence of name and lifecycle.
# It also that the name attribute should be unique.

class Project < ActiveRecord::Base
  validates_uniqueness_of :name
  validates_presence_of :name, :lifecycle
  has_many :deliverables
  belongs_to :user
end
