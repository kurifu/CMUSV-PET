# The users table contains the following column
#   id                integer
#   username          varchar(255)
#   email             varchar(255)
#   crypted_password  varchar(255)
#   password_salt     varchar(255)
#   persistence_token varchar(255)
#   user_class        varchar(255)
#   created_at        datetime
#   updated_at        datetime
#
# In the user model class, it will validate the presence of username and the format
# email password and confirmation of password.

class User < ActiveRecord::Base
  acts_as_authentic

  has_many :projects
end
